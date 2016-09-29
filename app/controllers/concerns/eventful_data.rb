module EventfulData


  def get_venues

    api_call("events/search?app_key=#{ENV[eventful_key]}&location=V0-001-001106373-0&date=future&page_size=100")

  end


  private

  def api_call(endpoint)
    uri = URI.parse("http://api.eventful.com/rest/#{endpoint}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.request(request).body
  end

end