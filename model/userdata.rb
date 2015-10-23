require 'taaze'
require 'json'
##
# Loads and returns full user collections
#
# Example:
#   user_collections = UserCollections.new('12522728')
#   puts user_collections.to_json
#
class UserCollections
  attr_reader :user_id, :collections

  def initialize(user_id)
    @user_id = user_id
  end

  def to_json
  end

  def load_collections
  end
end

##
# Loads and returns full user comments
#
# Example:
#   user_comments = UserComments.new('12522728')
#   puts user_comments.to_json
#
class UserComments
  attr_reader :user_id, :comments

  def initialize(user_id)
    @user_id = user_id
  end

  def to_json
  end

  def load_comments
  end
end
