class JambaseController < ApplicationController
include SpotifyData
include JambaseData

  def venues
    venues = get_venues(params[:venue_name])
    @venues = []

    venues.each do |venue|
      @venues << Venue.find_or_create_by(name: venue[:venue_name], address: venue[:address] ,jambase_id: venue[:id] )
    end

    if @venues.length == 0
      @errors = ['No venues found']
    end

    render 'events/index' 
  end

  def select_venue

    current_user.events.delete_all

    events = get_events_for_venue(params[:id])
    @events = []

    events.each do |event|
      new_event = Event.new
      new_event.user = current_user
      new_event.artist = Artist.find_or_create_by(name: event[:artist])
      new_event.venue = Venue.find_by(jambase_id: params[:id])
      new_event.date = event[:date]
      new_event.save
      @events << new_event
    end

    @events.each do |event|
      event.destroy if !get_artist_info(event.artist.name)
    end

    redirect_to '/events/rate'
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