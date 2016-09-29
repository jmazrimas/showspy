module EventfulData


  def get_venues(location, venue_name)

    params = {
      app_key: ENV["eventful_key"], 
      location: location, 
      keywords: venue_name
    }

    endpoint = "venues/search"

    results = JSON.parse(api_call(endpoint, params))['venues']

    if results
      venues_raw = results['venue']
      venues = []
      venues_raw.each { |v| venues << {venue_name: v['name'], address: clean_venue_address(v), id: v['id']} }
      venues
    end

  end


  private

  def api_call(endpoint,params)
    uri = URI.parse("http://api.eventful.com/json/#{endpoint}")
    uri.query = URI.encode_www_form(params)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.request(request).body
  end

  def clean_venue_address(venue)
    address = ""
    address += "#{venue['address']}, " if venue['address']
    address += "#{venue['city_name']}" if venue['city_name']
    address
  end

end