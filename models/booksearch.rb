require 'json'
require 'open-uri'
require 'date'
require 'uri'
require 'nokogiri'

class BookSearchTaaze
  API_URL = 'http://www.taaze.tw/search_go.html?keyword%5B%5D='
  API_URL_SUF = '&keyType%5B%5D=0&prodKind=0&prodCatId=0&catId=0&salePriceStart=&salePriceEnd=&saleDiscStart=0&saleDiscEnd=0&publishDateStart=&publishDateEnd=&prodRank=0&addMarkFlg=0'
  BOOK_INFO_URL = 'http://www.taaze.tw/beta/searchbookAgent.jsp?prodId='

  def initialize(keyword)
    parse_html(keyword)
  end

  def pricelist
    @pricelist ||= extract_pricelist
  end

  def parse_html(keyword)
    url = API_URL + URI.escape(keyword) + API_URL_SUF
    @doc = Nokogiri::HTML(open(url))
  end

  def extract_pricelist
    pricelist = []
    @doc.css('.searchresult_row').each do |r|
      book = {}
      book['source'] = 'taaze'
      style_str = r.at_css('.one')['style']
      book['img'] = style_str[style_str.index(/\(/)+1..style_str.index(/\)/)-1]
      id = r.at_css('.one')['rel']
      data = JSON.parse(open(BOOK_INFO_URL+id).read)[0]
      book['author'] = data['author']
      book['bookname'] = data['booktitle']
      book['ori_price'] = r.at_css('.two').css('ul li>span')[0].css('span')[0].text 
      book['price'] = r.at_css('.two').css('ul li>span')[1].css('span')[1].text
      pricelist << book
    end
    pricelist
  end
end
