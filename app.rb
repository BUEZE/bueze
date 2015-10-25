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
    'Not done yet, plz update API description.'
  end

  get '/api/v1/collections/:user_id.json' do
    content_type :json, :charset => 'utf-8'
    get_collections(params[:user_id]).to_json
  end

  get '/api/v1/comments/:user_id.json' do
    content_type :json, :charset => 'utf-8'
    get_comments(params[:user_id]).to_json
  end

  get '/api/v1/tags/:product_id.json' do
    content_type :json, :charset => 'utf-8'
    get_tags(params[:product_id]).to_json
  end
end
