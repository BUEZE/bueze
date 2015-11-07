ENV['RACK_ENV'] = 'test'

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }
require 'minitest/autorun'
require 'rack/test'
require 'vcr'
require 'webmock/minitest'

include Rack::Test::Methods

def app
  AppController
end

def random_num(n)
  srand(n)
  (0..n).map { ('0'..'9').to_a[rand(10)] }.join
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixures/vcr_cassettes'
  config.hook_into :webmock
end
