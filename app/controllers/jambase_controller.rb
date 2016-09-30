class JambaseController < ApplicationController
include SpotifyData
include JambaseData

  def venues
    @venues = get_venues(params[:venue_name])
    render 'shows/index' 
  end

  def select_venue

    @stuff = get_shows_for_venue(params[:id])

    render 'shows/index'
  end


end