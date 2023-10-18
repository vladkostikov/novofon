# frozen_string_literal: true

require "digest/md5"
require "openssl"
require "base64"
require "faraday"

module Novofon
  class Client
    include Methods

    def initialize(api_key, api_secret)
      @api_key = api_key
      @api_secret = api_secret
    end

    def request(method, path, params = {})
      raise "No auth data provided" unless @api_key && @api_secret

      params.merge!(format: "json")

      response = client.send(method, "/v1#{path}", params) do |request|
        request.headers["Accept"] = "application/json"
        request.headers["Authorization"] = "#{@api_key}:#{signature("/v1#{path}", params)}"
      end

      result = ActiveSupport::JSON.decode(response.body).with_indifferent_access
      raise Novofon::Error, "Error [HTTP #{response.status}]: #{result[:message]} " unless result[:status] == "success"

      result.except("status")
    rescue ActiveSupport::JSON.parse_error
      raise Novofon::Error, "Response is not JSON: #{response.body}"
    end

    protected

    def client
      @client ||= ::Faraday.new(url: "https://api.novofon.com") do |faraday|
        faraday.request :url_encoded
        faraday.response :logger if Novofon.log_requests
        faraday.adapter Faraday.default_adapter
      end
    end

    def signature(url, params)
      query = Hash[params.sort].to_query
      sign_str = url + query + Digest::MD5.hexdigest(query)
      Base64.encode64(OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha1"), @api_secret, sign_str)).strip
    end

    # Class methods
    class << self
      include Methods

      def request(method, path, params = {})
        # Make instance and execute request
        object = Novofon::Client.new(Novofon.api_key, Novofon.api_secret)
        object.request(method, path, params)
      end
    end
  end
end
