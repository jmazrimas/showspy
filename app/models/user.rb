class User < ApplicationRecord
  has_many :top_artists
  has_many :events
  has_many :artists, through: :top_artists


  def listening_genre_profile

    profile = Hash.new 0

    self.artists.each do |artist|
      artist.genre_list.each do |genre|
        profile[genre] += 1
      end
    end

    profile.sort_by {|_key, value| value}.to_h
  end


  def score_track_genres(genres)
    score = 0
    genres.each do |genre|
      if !listening_genre_profile[genre]
      else
        score += listening_genre_profile[genre]
      end
    end
    (score*100)/max_track_score
  end

  def max_track_score
    listening_genre_profile.inject(0) { |total, (k, v)| total + v }
  end

  def token_expiring?
    (token_expires_at - Time.now.utc) < 900
  end
  
end
