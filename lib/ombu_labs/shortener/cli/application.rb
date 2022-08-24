# frozen_string_literal: true

require "uri"
require "ombu_labs/shortener"

class MyCLI

  # `shorten URL` will contact rebrandly's API and use the right domain to
  # generate the shortened URL.

  # Example:
  #
  # $ shorten https://fastruby.io/tune
  # https://go.fastruby.io/tune-twt-779
  def self.start(args = [])
    return puts help if no_api_key?
    return puts invalid_uri if invalid_uri?(args)

    OmbuLabs::Shortener::RebrandlyClient.new(args).shorten
  end

  def self.help
    puts ""
    puts "Stopping. Can't run without REBRANDLY_API_KEY in your shell. "
    puts ""
    puts "Try following these steps:"
    puts ""
    puts "export REBRANDLY_API_KEY=<your api key>"
    puts "shorten <your long url here>"
  end

  def self.invalid_uri
    puts ""
    puts "Stopping. Can't run with an invalid URL. "
    puts ""
    puts "Try following these steps:"
    puts ""
    puts "export REBRANDLY_API_KEY=<your api key>"
    puts "shorten <valid long url here>"
  end

  def self.invalid_uri?(args = [])
    url = args.first
    uri = URI.parse(url)
    false
  rescue URI::InvalidURIError
    true
  end

  # REBRANDLY_API_KEY env variable present?
  #
  # @return [Boolean]
  def self.no_api_key?
    ENV['REBRANDLY_API_KEY'].to_s == ''
  end
end