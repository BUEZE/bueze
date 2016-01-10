require 'json'
require 'open-uri'
require 'date'
require 'uri'
require 'nokogiri'

module BookSearch
  
  def initialize(keyword)
    parse_html(keyword)
  end

  def pricelist
    @pricelist ||= extract_pricelist
  end

end


class BookSearchTaaze
  
  include BookSearch
  
  API_URL = 'http://www.taaze.tw/search_go.html?keyword%5B%5D='
  API_URL_SUF = '&keyType%5B%5D=0&prodKind=0&prodCatId=0&catId=0&salePriceStart=&salePriceEnd=&saleDiscStart=0&saleDiscEnd=0&publishDateStart=&publishDateEnd=&prodRank=0&addMarkFlg=0'
  BOOK_INFO_URL = 'http://www.taaze.tw/beta/searchbookAgent.jsp?prodId='
  BOOK_CONTENT_URL = 'http://www.taaze.tw/usedList.html?oid='

  def parse_html(keyword)
    url = API_URL + URI.escape(keyword) + API_URL_SUF
    @doc = Nokogiri::HTML(open(url))
  end

  def extract_pricelist
    pricelist = []
    unless @doc.css('.searchresult_row').empty?
      @doc.css('.searchresult_row').take(10).each do |r|
        book = {}
        book['source'] = 'taaze'
        style_str = r.at_css('.one')['style']
        book['img'] = style_str[style_str.index(/\(/)+2..style_str.index(/\)/)-2]
        id = r.at_css('.one')['rel']
        data = JSON.parse(open(BOOK_INFO_URL+id).read)[0]
        book['author'] = data['author']
        book['bookname'] = data['booktitle']
        book['ori_price'] = r.at_css('.two').css('ul li>span')[0].css('span')[0].text 
        book['price'] = r.at_css('.two').css('ul li>span')[1].css('span')[1] ? r.at_css('.two').css('ul li>span')[1].css('span')[1].text : r.at_css('.two').css('ul li>span')[1].css('span')[0].text
        book['link'] = BOOK_CONTENT_URL + id
        book['id'] = id
        pricelist << book
      end
    end
    pricelist
  end

end


class BookSearchBooks
  
  include BookSearch

  API_URL = 'http://search.books.com.tw/exep/prod_search.php?cat=BKA&key='

  def parse_html(keyword)
    url = API_URL + URI.escape(keyword)
    @doc = Nokogiri::HTML(open(url))
  end

  def extract_pricelist
    pricelist = []
    unless @doc.css('form ul li.item').empty?
      @doc.css('form ul li.item').take(10).each_with_index do |r|
        book = {}
        book['source'] = 'books'
        book['img'] = r.css('a img')[0]['data-original']
        book['bookname'] = r.at_css('h3').text
        book['link'] = r.at_css('h3 a')['href']
        book['author'] = r.at_css('a[rel=go_author]').text
        book['ori_price'] = '--'
        book['price'] = r.css('span.price b')[1] ? r.css('span.price b')[1].text : r.css('span.price b')[0].text
        pricelist << book
      end
    end
    pricelist
  end
end

