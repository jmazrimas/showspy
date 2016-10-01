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
      new_event = Event.find_or_initialize_by(event)
      new_event.venue = Venue.find_by(jambase_id: params[:id])
      new_event.user = current_user
      puts new_event.save
      @events << new_event
    end

    spotify_ids = []

    @events.each do |event|
      spotify_ids << get_artist_id(event.artist)
    end

    @stuff = spotify_ids

    render 'shows/index'
  end


end