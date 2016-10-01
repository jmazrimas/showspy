class ShowsController < ApplicationController
include SpotifyData
include EventfulData

  def index

    if logged_in?

      # @stuff = top_artists
      # @stuff = get_venues('60622','Double Door')

      tracks = get_top_tracks("6naGTpITCSx3St2nZgxDuz")

      @stuff = get_track_attributes(tracks)

    end

  end


end


# app_key=zz4xQx8CgMczb3Gp

# http://api.eventful.com/rest/venues/search?app_key=zz4xQx8CgMczb3Gp&keywords=Double+Door&location=60622

# http://api.eventful.com/rest/events/search?app_key=zz4xQx8CgMczb3Gp&location=V0-001-001106373-0&date=future&page_size=100
