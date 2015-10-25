require 'sinatra/base'
require_relative './model/userdata'
require_relative './model/bookinfo'

# Simle web service for taaze api
class BuezeApp < Sinatra::Base
  helpers do
    def get_collections(user_id)
      UserCollections.new(user_id)
    rescue
      halt 404
    end

    def get_comments(user_id)
      UserComments.new(user_id)
    rescue
      halt 404
    end

    def get_tags(product_id)
      BookInfo.new(product_id)
    rescue
      halt 404
    end
  end

  get '/' do
    'Bueze service is up and working. See more info at it\'s ' \
    '<a href="https://github.com/BUEZE/bueze">' \
    'Github repo</a>' \
    '<br> Current Version: '\
    '0.0.1'
  end

  get '/api/v1/user/:user_id' do
    content_type :json, charset: 'utf-8'
    user_info = {}
    user_info['user_id'] = params[:user_id]
    user_info['collections'] = get_collections(params[:user_id]).collections
    user_info['comments'] = get_comments(params[:user_id]).comments
    user_info.to_json
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
