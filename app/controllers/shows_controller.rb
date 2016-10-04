class ShowsController < ApplicationController
include SpotifyData
# include EventfulData

before_action :check_spotify_token, only: [:rate, :get_ratings]

  def index

    if logged_in?
      refresh_token
    end

  end

  def rate

    ratings = get_ratings
    @stuff = ratings
    render 'shows/index' 

  end

  def get_ratings
    
    ratings = {}
    current_user.events.each do |event|

      if !event.artist.genre_list
        get_artist_info(event.artist.name)
      end

      if current_user.artists.include?(event.artist)
        score = 100
      else
        score = current_user.score_track_genres(event.artist.genre_list)
      end

      ratings[event.artist.name] = score if score > 0
    end

    ratings.sort_by {|_key, value| -value}.to_h

  end

  private

  def check_spotify_token
    if current_user.token_expiring?
      refresh_token
    end
  end

end


# app_key=zz4xQx8CgMczb3Gp

# http://api.eventful.com/rest/venues/search?app_key=zz4xQx8CgMczb3Gp&keywords=Double+Door&location=60622

# http://api.eventful.com/rest/events/search?app_key=zz4xQx8CgMczb3Gp&location=V0-001-001106373-0&date=future&page_size=100
