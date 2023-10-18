# frozen_string_literal: true

require "active_support"
require "active_support/core_ext"
require "active_support/json"
require "active_support/hash_with_indifferent_access"

require_relative "novofon/version"

require "novofon/methods"
require "novofon/client"
require "novofon/error"

module Novofon
  mattr_accessor :api_key, :api_secret, :log_requests
end
