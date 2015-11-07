require 'sinatra'
require 'sinatra/activerecord'
require '../config/environments'

class Bookranking < ActiveRecord::Base
	def initialize(description, booknames, rank, price, author, date)
		@description = description
		@booknames = booknames
		@rank = rank
        @price = price
        @author = author
        @date = date
	end

	def save()

	end
end