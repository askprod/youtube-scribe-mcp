class ToolsController < ApplicationController
  def youtube_captions_for_query
    query = params[:query]
    api_key = Rails.application.credentials.youtube_api_key

    search_url = "https://www.googleapis.com/youtube/v3/search"
    search_params = {
      part: "snippet",
      q: query,
      maxResults: 20,
      order: "viewCount",
      type: "video",
      key: api_key
    }

    search_response = RestClient.get(search_url, { params: search_params })
    unless search_response.code == 200
      render json: { error: "YouTube search error: #{search_response.message}" }, status: 500 and return
    end

    results = []

    JSON.parse(search_response.body)["items"].each do |item|
      video_id = item.dig("id", "videoId")
      video_title = item.dig("snippet", "title")

      # Use YouTube Transcriber API to get the transcript
      transcriber_api_url = "https://youtube-transcriber-api.vercel.app/v1/transcripts"
      transcriber_params = { id: video_id, type: "text" }

      begin
        transcriber_response = RestClient.get(transcriber_api_url, { params: transcriber_params })
        transcript_data = JSON.parse(transcriber_response.body)

        captions = transcript_data["transcripts"].map do |transcript|
          {
            language: transcript["language"],
            text: transcript["text"]
          }
        end

        results << {
          videoId: video_id,
          title: video_title,
          captions: captions
        }
      rescue RestClient::ExceptionWithResponse => e
        Rails.logger.error "Failed to fetch transcript for video ID #{video_id}: #{e.response}"
        next
      end
    end

    render json: results
  end

  def openai_response
    prompt = params[:prompt]

    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4.1",
        messages: [ { role: "user", content: prompt } ],
        max_tokens: 150
      }
    )

    if response
      render json: { response: response.choices.first.text.strip }
    else
      render json: { error: "Failed to get a response from OpenAI" }, status: 500
    end
  end
end
