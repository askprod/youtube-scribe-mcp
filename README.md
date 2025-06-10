# YouTube Captions API

This Rails application serves as an MCP (Model-Controller-Presenter) server to fetch YouTube video captions and interact with OpenAI's API. It provides endpoints to search for YouTube videos and retrieve their captions, as well as generate responses using OpenAI's models.

## Features
- Fetch YouTube video data and captions using the YouTube Data API and a third-party transcriber API.
- Generate text responses using OpenAI's API.

## Setup

### Prerequisites
- Ruby and Rails installed on your system.
- YouTube Data API key.
- OpenAI API key.

### Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd youtube_captions_api
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up environment variables:
   - Use a tool like `dotenv` to manage environment variables.
   - Set `YOUTUBE_API_KEY` and `OPENAI_ACCESS_TOKEN` in your environment.

4. Run the server:
   ```bash
   rails server
   ```

## Usage

### Endpoints

- **GET /youtube_captions**: Fetches YouTube video data and captions based on a search query.
  - **Parameters**: `query` - The search term for YouTube videos.

- **POST /openai_response**: Generates a text response using OpenAI's API.
  - **Parameters**: `prompt` - The prompt text for generating a response.

## Development

### Testing
- Run tests using:
  ```bash
  rails test
  ```

### Linting
- Ensure code quality with RuboCop:
  ```bash
  rubocop
  ```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License
This project is open source and available under the [MIT License](LICENSE).

## Acknowledgments
- [YouTube Data API](https://developers.google.com/youtube/v3)
- [OpenAI API](https://platform.openai.com/docs/api-reference)
- [ruby-openai gem](https://github.com/alexrudall/ruby-openai)
