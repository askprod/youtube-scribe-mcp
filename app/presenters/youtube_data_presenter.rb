class YoutubeDataPresenter
  def initialize(data)
    @data = data
  end

  def as_json
    @data.map do |item|
      {
        video_id: item[:videoId],
        title: item[:title],
        captions: format_captions(item[:captions])
      }
    end
  end

  private

  def format_captions(captions)
    captions.map do |caption|
      {
        language: caption[:language],
        text: caption[:text]
      }
    end
  end
end
