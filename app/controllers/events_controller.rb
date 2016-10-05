class EventsController < ApplicationController
include SpotifyData
before_action :check_spotify_token, only: [:rate, :get_ratings]

  def index

  end

  def rate

    ratings = get_ratings
    @events = ratings
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

      ratings[event.artist] = score if score > 0
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
