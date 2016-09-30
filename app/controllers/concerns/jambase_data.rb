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

    # results = JSON.parse(api_call(url, endpoint, params))['Venues']

    # if results
    #   venues=[]
    #   results.each { |v| venues << {venue_name: v['Name'], address: clean_venue_address(v), id: v['Id']} }
    #   venues
    # end

    venues = []
    venues << {venue_name: 'Empty Bottle', address: '1035 N Western Ave , Chicago', id: 296}
    venues << {venue_name: 'Empty Bottle Saloon', address: '30 West Main Street, Middletown', id: 125443}
    venues 

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

    # results = JSON.parse(api_call(url, endpoint, params))['Events']

    # if results
    #   events = []
    #   results.each do |event| 
    #     event['Artists'].each { |artist| events << {date: event['Date'], artist: artist['Name'] } }
    #   end
    #   events
    # end

    events = [{:date=>"2016-09-30T21:00:00", :artist=>"Merchandise"}, {:date=>"2016-09-30T21:00:00", :artist=>"Public Memory"}, {:date=>"2016-10-01T00:00:00", :artist=>"Public Memory"}, {:date=>"2016-10-02T21:00:00", :artist=>"Goblin Cock"}, {:date=>"2016-10-05T21:00:00", :artist=>"Kikagaku Moyo"}, {:date=>"2016-10-07T00:00:00", :artist=>"Seratones"}, {:date=>"2016-10-11T21:00:00", :artist=>"Cymbals Eat Guitars"}, {:date=>"2016-10-11T21:00:00", :artist=>"Field Mouse"}, {:date=>"2016-10-13T21:00:00", :artist=>"Born Ruffians"}, {:date=>"2016-10-14T00:00:00", :artist=>"Oozing Wound"}, {:date=>"2016-10-16T21:00:00", :artist=>"White Fang"}, {:date=>"2016-10-20T00:00:00", :artist=>"Nots"}, {:date=>"2016-10-21T21:00:00", :artist=>"Cass McCombs"}, {:date=>"2016-10-21T21:00:00", :artist=>"Delicate Steve"}, {:date=>"2016-10-22T21:00:00", :artist=>"Vinyl Williams"}, {:date=>"2016-10-22T21:00:00", :artist=>"Temples"}, {:date=>"2016-10-26T00:00:00", :artist=>"Itasca"}, {:date=>"2016-10-27T00:00:00", :artist=>"White Lung"}, {:date=>"2016-10-30T00:00:00", :artist=>"La Sera"}, {:date=>"2016-11-02T00:00:00", :artist=>"Protomartyr"}, {:date=>"2016-11-02T00:00:00", :artist=>"The Gotobeds"}, {:date=>"2016-11-03T00:00:00", :artist=>"Ricky Eat Acid"}, {:date=>"2016-11-04T00:00:00", :artist=>"Natural Child"}, {:date=>"2016-11-05T00:00:00", :artist=>"BRONCHO"}, {:date=>"2016-11-05T00:00:00", :artist=>"Sports"}, {:date=>"2016-11-06T00:00:00", :artist=>"S U R V I V E"}, {:date=>"2016-11-10T00:00:00", :artist=>"Dead Leaf Echo"}, {:date=>"2016-11-16T00:00:00", :artist=>"Nobunny"}, {:date=>"2016-11-17T00:00:00", :artist=>"DZ Deathrays"}, {:date=>"2016-11-17T00:00:00", :artist=>"Dune Rats"}, {:date=>"2016-11-19T00:00:00", :artist=>"True Widow"}, {:date=>"2016-11-20T00:00:00", :artist=>"Thee Oh Sees"}, {:date=>"2016-11-27T00:00:00", :artist=>"Luke Bell"}, {:date=>"2016-12-02T00:00:00", :artist=>"Earthless"}, {:date=>"2016-12-02T00:00:00", :artist=>"Ruby The Hatchet"}, {:date=>"2016-12-03T00:00:00", :artist=>"King Khan & BBQ Show"}] 

    events

  end

  private 

  def clean_venue_address(venue)
    address = ""
    address += "#{venue['Address']}, " if venue['Address']
    address += "#{venue['City']}" if venue['City']
    address
  end

end