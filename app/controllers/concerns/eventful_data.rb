module EventfulData
  include APICalls

  def get_venues(venue_name)

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

  def get_shows_for_venue(venue_id)

    params = {
      app_key: ENV["eventful_key"], 
      location: venue_id
    }

    endpoint = "events/search"

    url = "http://api.eventful.com/json/"

    JSON.parse(api_call(url, endpoint, params))['events']

  end

  private

  def clean_venue_address(venue)
    address = ""
    address += "#{venue['address']}, " if venue['address']
    address += "#{venue['city_name']}" if venue['city_name']
    address
  end

end