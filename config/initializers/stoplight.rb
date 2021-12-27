# frozen_string_literal: true

require 'stoplight'
require 'redis'

redis = Redis.new(host: ENV["REDIS"])

Stoplight::Light.default_data_store = Stoplight::DataStore::Redis.new(redis)