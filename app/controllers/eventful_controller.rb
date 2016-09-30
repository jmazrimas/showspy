class EventfulController < ApplicationController
include SpotifyData
include EventfulData
include JambaseData

  def venues
    # @venues = get_venues(params[:location],params[:venue_name])
    @venues = jb_get_venues(params[:venue_name])
    render 'shows/index' 
  end

  def select_venue

    @stuff = get_shows_for_venue(params[:id])['event']

    render 'shows/index'
  end


end