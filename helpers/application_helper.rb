# Helper methods for application_controller
module ApplicationHelpers
  API_BASE_URI = 'http://bueze.herokuapp.com'
  API_VER = '/api/v1/'

  def bueze_api_url(resource)
    URI.join(API_BASE_URI, API_VER, resource).to_s
  end

  def array_strip(str_arr)
    str_arr.map(&:strip).reject(&:empty?)
  end

  def error_send(url, msg)
    flash[:error] = msg
    redirect url
    halt 303 # http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
  end
end
