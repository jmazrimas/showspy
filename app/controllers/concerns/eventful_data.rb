module EventfulData


  def get_venues(location, venue_name)

    params = {app_key: ENV["eventful_key"], location: location, keywords: venue_name}
    endpoint = "venues/search"

    venues_raw = JSON.parse(api_call(endpoint, params))['venues']['venue']

    venues = []

    venues_raw.each { |v| venues << v['name']}

    venues

  end


  private

  def api_call(endpoint,params)
    uri = URI.parse("http://api.eventful.com/json/#{endpoint}")
    uri.query = URI.encode_www_form(params)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.request(request).body
  end

end