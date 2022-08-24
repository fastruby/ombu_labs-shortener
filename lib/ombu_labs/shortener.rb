# frozen_string_literal: true

require "rebrandly"
require_relative "shortener/version"

module OmbuLabs
  module Shortener
    class RebrandlyClient
      def initialize(args = [])
        @url = args.first
        Rebrandly.configure do |config|
          config.api_key = ENV['REBRANDLY_API_KEY']
        end
        @api = Rebrandly::Api.new
      end

      def shorten
        puts "Shortening: #{@url}"
        domain = find_domain
        link = @api.shorten(@url, domain: domain.to_h)
        puts "Shortened: SHORT: #{link.short_url}"

      rescue Rebrandly::RebrandlyError => err
        puts "Error: #{err.message}"
      end

      private

      def find_domain
        uri = URI.parse(@url)

        domain = uri.host.split(".")[-2..-1].join(".")

        domains = @api.send :rebrandly_request, :get, 'domains', {}

        # HACK because the rebrandly gem doesn't work as expected
        result = domains.detect do |dm|
          dm["fullName"].split(".")[-2..-1].join(".") == domain
        end
        result = @api.domain(result["id"]) if result

        result || @api.domains.first
      end
    end

    class Error < StandardError; end
    # Your code goes here...
  end
end
