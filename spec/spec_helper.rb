ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'vcr'
require 'webmock/minitest'
require_relative '../app'

include Rack::Test::Methods

def app
  BuezeApp
end

def random_num(n)
  srand(n)
  (0..n).map { ('0'..'9').to_a[rand(10)] }.join
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixures/vcr_cassettes'
  config.hook_into :webmock
end
