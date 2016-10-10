class EventsController < ApplicationController
include SpotifyData
before_action :check_spotify_token, only: [:rate, :get_ratings]

  def index

  end

  def rate

    @rated_events = get_ratings
    if @rated_events.length > 0
      @venue = @rated_events.first[0].venue
    end

    render 'events/index' 

  end

  def get_ratings
    
    ratings = {}
    current_user.events.each do |event|

      if !event.artist.genre_list
        get_artist_info(event.artist.name)
      end

      if current_user.artists.include?(event.artist)
        score = 100
      elsif !event.artist.genre_list
      else
        score = current_user.score_track_genres(event.artist.genre_list)
      end

      ratings[event] = score if event.artist.genre_list && score > 0
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
