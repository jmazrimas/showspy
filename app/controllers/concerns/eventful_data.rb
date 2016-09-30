module EventfulData
  include APICalls

  def get_venues(location, venue_name)

    params = {
      app_key: ENV["eventful_key"], 
      location: location, 
      keywords: venue_name
    }

    endpoint = "venues/search"

    url = "http://api.eventful.com/json/"

    results = JSON.parse(api_call(url, endpoint, params))['venues']

    if results
      venues_raw = results['venue']
      venues = []
      venues_raw.each { |v| venues << {venue_name: v['name'], address: clean_venue_address(v), id: v['id']} }
      venues
    end

  end

  def select_venue(venue_id)

  end

  private

  def clean_venue_address(venue)
    address = ""
    address += "#{venue['address']}, " if venue['address']
    address += "#{venue['city_name']}" if venue['city_name']
    address
  end

end