# Helpers for main sinarta web application
module ScrapeHelpers

  def get_rankings(source):
    BookRankingList.new(source)
  rescue
    halt 404
  end

  def get_tags(product_id)
    BookInfo.new(product_id)
  rescue
    halt 404
  end
end
