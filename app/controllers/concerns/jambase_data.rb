module JambaseData
  include APICalls

  def get_venues(venue_name)

    endpoint = "venues"
    url = "http://api.jambase.com/"
    params = {
      api_key: ENV["jambase_key"], 
      page: 0, 
      name: venue_name,
      o: 'json'
    }

    results = JSON.parse(api_call(url, endpoint, params))['Venues']

    if results
      venues=[]
      results.each { |v| venues << {venue_name: v['Name'], address: clean_venue_address(v), id: v['Id']} }
      venues
    end

  end

  private 

  def clean_venue_address(venue)
    address = ""
    address += "#{venue['Address']}, " if venue['Address']
    address += "#{venue['City']}" if venue['City']
    address
  end

end