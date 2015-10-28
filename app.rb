require 'sinatra/base'
require_relative 'bueze_helpers'

# Simle web service for taaze api
class BuezeApp < Sinatra::Base
  helpers BuezeHelpers

  get '/' do
    'Bueze service is up and working. See more info at it\'s ' \
    '<a href="https://github.com/BUEZE/bueze">' \
    'Github repo</a>' \
    '<br> Current Version: '\
    '0.0.1'
  end

  get '/api/v1/user/:user_id' do
    content_type :json, charset: 'utf-8'
    get_userinfo(params[:user_id]).to_json
  end

  get '/api/v1/collections/:user_id.json' do
    content_type :json, charset: 'utf-8'
    get_collections(params[:user_id]).to_json
  end

  get '/api/v1/comments/:user_id.json' do
    content_type :json, charset: 'utf-8'
    get_comments(params[:user_id]).to_json
  end

  get '/api/v1/tags/:product_id.json' do
    content_type :json, charset: 'utf-8'
    get_tags(params[:product_id]).to_json
  end
end
