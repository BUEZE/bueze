##
# Loads and returns full book info
#
# Example:
#   book = BookInfo.new('11100763252')
#   puts book.to_json
#
class BookInfo
  attr_reader :product_id, :title, :tags

  def initialize(product_id)
    @product_id = product_id
  end

  def to_json
  end

  def load_tags
  end
end
