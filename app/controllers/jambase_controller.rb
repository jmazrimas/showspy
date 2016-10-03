class JambaseController < ApplicationController
include SpotifyData
include JambaseData

  def venues
    venues = get_venues(params[:venue_name])
    @venues = []

    venues.each do |venue|
      @venues << Venue.find_or_create_by(name: venue[:venue_name], address: venue[:address] ,jambase_id: venue[:id] )
    end

    render 'shows/index' 
  end

  def select_venue
    events = get_events_for_venue(params[:id])
    @events = []

    events.each do |event|
      # This is an issue -- user needs to be assigned on event creation, not after the fact
      new_event = Event.find_or_initialize_by(event)
      new_event.venue = Venue.find_by(jambase_id: params[:id])
      new_event.user = current_user
      puts new_event.save
      @events << new_event
    end

    # # Below needs to be refactored out

    # reccos = {}
    # @events.each do |event|
    #   reccos[event.artist] = {spotify_id: get_artist_id(event.artist)}
    # end

    # # spotify_ids = ['6naGTpITCSx3St2nZgxDuz','1v9FPBHwuI4FjR7ewOifmJ']

    # reccos.each_key do |artist|
    #   reccos[artist][:related_list] = return_related_list(reccos[artist][:spotify_id])
    # end

    # @stuff = reccos

    @stuff = {}

    @events.each do |event|
      @stuff[event.artist] = score_track_genres(event.artist.genre_list)
    end

    render 'shows/index'
  end



  def return_related_list(spotify_id)
    recc_list = []
    get_related_artists(spotify_id)['tracks'].each do |track|
      track['artists'].each do |artist|
        if !recc_list.include?(artist['name'])
          recc_list << artist['name']
        end
      end
    end
    recc_list
  end

end