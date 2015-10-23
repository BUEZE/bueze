require 'sinatra/base'

# Simle web service for taaze api
class BuezeApp < Sinatra::Base
  helpers do
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
