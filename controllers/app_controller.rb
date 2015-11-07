require 'sinatra/base'

# Simle web service for taaze api
class AppController < Sinatra::Base
  helpers BuezeHelpers

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

    bookranking = Bookranking.new(
      booknames: req['booknames'].to_json,
      rank: req['rank'].to_json,
      price: req['price'].to_json,
      price_description: req['price_description'].to_json,
      author: req['author'].to_json,
      date: req['date'].to_json,
      source: req['source'].to_json)
    if bookranking.save
      status 201
      redirect "/api/v1/bookranking/#{bookranking.id}", 303
    else
      halt 500, 'Error saving bookranking request to the database'
    end
  end

  # Get the data at index
  get_bookranking = lambda do
    content_type :json, charset: 'utf-8'
    begin
      bookranking = Bookranking.find(params[:id])
      booknames = bookranking.booknames
      rank = bookranking.rank
      price = bookranking.price
      price_description = bookranking.price_description
      author = bookranking.author
      date = bookranking.date
      source = bookranking.source
      logger.info({ id: bookranking.id, 
                    booknames: booknames,
                    rank: rank,
                    price: price,
                    price_description: price_description,
                    author: author,
                    date: date,
                    source: source
                    }.to_json)
    rescue
      halt 400
    end

    # begin
    #   results = check_badges(usernames, badges)
    # rescue
    #   halt 500, 'Lookup of Codecademy failed'
    # end
    { id: bookranking.id, 
      booknames: booknames,
      rank: rank,
      price: price,
      price_description: price_description,
      author: author,
      date: date,
      source: source
      }.to_json
  end

  # Web API Routes
  get '/api/v1/bookranking/:id', &get_bookranking
  post '/api/v1/bookranking', &post_bookranking
  post '/api/v1/bookranking/', &post_bookranking
end
