require_relative 'spec_helper'
require 'json'
require 'yaml'

user_from_file = YAML.load(File.read('./spec/fixures/user.yml'))

describe 'Getting the root of the service' do
  it 'should return ok' do
    get '/'
    # p last_response
    last_response.must_be :ok?
    last_response.body.must_match(/bueze/i)
  end
end

describe 'Getting the user data' do
  it 'should get their infos' do
    VCR.use_cassette('cadet') do
      get '/api/v1/user/12522728'
    end
    last_response.must_be :ok?
    body = JSON.parse(last_response.body)
    body['collections'].size.must_equal user_from_file['collections'].size
    body['comments'].size.must_equal user_from_file['comments'].size
    body['user_id'].must_equal user_from_file['user_id']
  end

  it 'should return empty data for unknown user' do
    VCR.use_cassette('cadet_empty') do
      get "/api/v1/user/#{random_num(8)}"
    end
    body = JSON.parse(last_response.body)
    if (body['collections'].size == 0 && body['comments'].size == 0)
      print "The user #{random_num(8)} may not exists"
    end
  end
end
