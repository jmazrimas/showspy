module JambaseData
  include APICalls
  require 'date'

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

  def get_shows_for_venue(venue_id)

    endpoint = "events"
    url = "http://api.jambase.com/"
    params = {
      api_key: ENV["jambase_key"], 
      page: 0, 
      venueId: venue_id,
      startDate: DateTime.now,
      o: 'json'
    }

    results = JSON.parse(api_call(url, endpoint, params))['Events']

    if results
      events = []
      results.each do |event| 
        event['Artists'].each { |artist| events << {date: event['Date'], artist: artist['Name'] } }
      end
      events
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