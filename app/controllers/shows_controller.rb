class ShowsController < ApplicationController
include SpotifyData
include EventfulData

  def index

    if logged_in?

      @stuff = []

      if session[:top_artists]
        session[:top_artists].each do |id|
          @stuff << Artist.find_by(id: id)
        end
      end

      # session[:top_artists]=build_user_top_artist_data.map(&:id)

      current_user.update(artists: build_user_top_artist_data)

      # @stuff = top_artists
      # @stuff = get_venues('60622','Double Door')

      # artist_id = get_artist_id("Merchandise")

      # @stuff = get_top_tracks(artist_id)

      # @stuff = get_track_attributes(tracks)

    end

  end


end


# app_key=zz4xQx8CgMczb3Gp

# http://api.eventful.com/rest/venues/search?app_key=zz4xQx8CgMczb3Gp&keywords=Double+Door&location=60622

# http://api.eventful.com/rest/events/search?app_key=zz4xQx8CgMczb3Gp&location=V0-001-001106373-0&date=future&page_size=100
