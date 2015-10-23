require 'sinatra/base'
require_relative './model/userdata'
require_relative './model/bookinfo'

# Simle web service for taaze api
class BuezeApp < Sinatra::Base
  helpers do
    def get_collections(user_id)
    rescue
      halt 404
    end

    def get_comments(user_id)
    rescue
      halt 404
    end

    def get_tags(product_id)
    rescue
      halt 404
    end
  end

  get '/' do
  end

  get '/api/v1/collections/:user_id.json' do
  end

  get '/api/v1/comments/:user_id.json' do
  end

  get '/api/v1/tags/:product_id.json' do
  end
end
