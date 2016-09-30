module JambaseData
  include APICalls

  def jb_get_venues(venue_name)

    params = {
      api_key: ENV["jambase_key"], 
      page: 0, 
      name: venue_name,
      o: 'json'
    }

    endpoint = "venues"

    url = "http://api.jambase.com/"

    # results = JSON.parse(api_call(url, endpoint, params))['Venues']

    # if results
    #   results.each { |v| venues << {venue_name: v['Name'], address: jb_clean_venue_address(v), id: v['id']} }
    #   venues
    # end

    results = JSON.parse(api_call(url, endpoint, params))['Venues']

    if results
      venues=[]
      results.each { |v| venues << {venue_name: v['Name'], address: jb_clean_venue_address(v), id: v['Id']} }
      venues
    end

  end

  private 

  def jb_clean_venue_address(venue)
    address = ""
    address += "#{venue['Address']}, " if venue['Address']
    address += "#{venue['City']}" if venue['City']
    address
  end

end