class ShowsController < ApplicationController
include SpotifyData

  def index

    @stuff = top_artists

  end


end