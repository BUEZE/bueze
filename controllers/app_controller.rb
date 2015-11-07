require 'sinatra/base'

# Simle web service for taaze api
class AppController < Sinatra::Base
  helpers BuezeHelpers, ScrapeHelpers

  configure :production, :development do
    enable :logging
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

  # Post bookrank JSON data and save to database
  post_bookranking = lambda do
    content_type :json
    begin
      req = JSON.parse(request.body.read)
      logger.info req
    rescue
      halt 400
    end

    rankinglist = get_ranking(req['source'])

    flag = true
    rankinglist.each do |book|
      _book = Bookranking.new(
        booknames: book['booknames'].to_json,
        rank: book['rank'].to_json,
        price: book['price'].to_json,
        price_description: book['price_description'].to_json,
        author: book['author'].to_json,
        date: book['date'].to_json,
        prod_id: book['prod_id'].to_json,
        source: book['source'].to_json)
      unless _book.save
        flag = false
      end
    end
    
    if flag
      status 201
      redirect "/api/v1/bookranking/#{rankinglist[0]['date']}", 303
    else
      halt 500, 'Some error occured when saving bookranking request to the database'
    end
  end

  # Get the data at index
  get_bookranking = lambda do
    content_type :json, charset: 'utf-8'
    begin
      p bookranking = Bookranking.where(date: Date.parse(params[:date]))
      logger.info(bookranking.to_json)
    rescue
      halt 400
    end

    bookranking.to_json
  end

  # Web API Routes
  get '/api/v1/bookranking/:date', &get_bookranking
  post '/api/v1/bookranking', &post_bookranking
  post '/api/v1/bookranking/', &post_bookranking
end
