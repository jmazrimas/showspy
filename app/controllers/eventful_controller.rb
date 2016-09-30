class EventfulController < ApplicationController
include SpotifyData
include EventfulData

  def venues
    @venues = get_venues(params[:location],params[:venue_name])
    render 'shows/index' 
  end



end