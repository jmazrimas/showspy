class ShowsController < ApplicationController
include SpotifyData
include EventfulData

  def index

    if logged_in? && current_user.artists.count == 0

      current_user.update(artists: build_user_top_artist_data)

    end

  end

  def rate

    ratings = {}

    current_user.events.each do |event|
      if !event.artist.genre_list
        get_artist_info(event.artist.name)
      end

      if current_user.artists.include?(event.artist)
        score = 1000
      else
        score = current_user.score_track_genres(event.artist.genre_list)
      end

      ratings[event.artist.name] = score if score > 0

    end

    @stuff = ratings.sort_by {|_key, value| -value}.to_h 

    render 'shows/index' 

  end

end


# app_key=zz4xQx8CgMczb3Gp

# http://api.eventful.com/rest/venues/search?app_key=zz4xQx8CgMczb3Gp&keywords=Double+Door&location=60622

# http://api.eventful.com/rest/events/search?app_key=zz4xQx8CgMczb3Gp&location=V0-001-001106373-0&date=future&page_size=100
