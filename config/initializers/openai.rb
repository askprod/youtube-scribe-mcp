OpenAI.configure do |config|
  config.access_token = Rails.application.credentials.open_ai_api_key
  config.log_errors = true # Enable logging for development
end
