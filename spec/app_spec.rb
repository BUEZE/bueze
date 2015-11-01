require_relative 'spec_helper'
require 'json'
require 'yaml'

USER_ID = %w(13193872 12522728 13472924)
BOOK_ID = %w(11100763435 11100745134 11100714084 11303096752)

user_from_file = YAML.load(File.read('./spec/fixures/user.yml'))
tags_from_file = YAML.load(File.read('./spec/fixures/tags.yml'))

describe 'Getting the root of the service' do
  it 'should return ok' do
    get '/'
    # p last_response
    last_response.must_be :ok?
    last_response.body.must_match(/bueze/i)
  end
end

describe 'Getting the user data' do
  USER_ID.each do |user_id|
    it 'should get their infos' do
      VCR.use_cassette("bueze_user_#{user_id}") do
        get "/api/v1/user/#{user_id}"
      end
      last_response.must_be :ok?
      body = JSON.parse(last_response.body)
      body['collections'].size.must_equal user_from_file[user_id]['collections'].size
      body['comments'].size.must_equal user_from_file[user_id]['comments'].size
      body['user_id'].must_equal user_from_file[user_id]['user_id']
    end
  end

  it 'should return empty data for unknown user' do
    VCR.use_cassette('bueze_user_empty') do
      get "/api/v1/user/#{random_num(8)}"
    end
    body = JSON.parse(last_response.body)
    if (body['collections'].size == 0 && body['comments'].size == 0)
      puts "\nThe user #{random_num(8)} may not exists since there's no any collections nor comments of this user"
    end
  end
end

describe 'Getting the book data' do
  BOOK_ID.each do |book_id|
    it 'should get book info' do
      VCR.use_cassette("bueze_book_#{book_id}") do
        get "/api/v1/tags/#{book_id}.json"
      end
      last_response.must_be :ok?
      body = JSON.parse(last_response.body)
      body['tags'].size.must_equal tags_from_file[book_id].size
    end
  end

  it 'should return 404 for unknown book' do
    VCR.use_cassette('bueze_book_empty') do
      get "/api/v1/tags/#{random_num(11)}"
    end
    last_response.must_be :not_found?
  end
end
