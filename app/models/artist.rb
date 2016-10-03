class Artist < ApplicationRecord
  has_many :tracks
  has_many :events
  serialize :genre_list


  def average_track_profile
    sql = "select avg(danceability) danceability, avg(energy) energy, avg(loudness) loudness, avg(speechiness) speechiness, avg(acousticness) acousticness, avg(instrumentalness) instrumentalness, avg(liveness) liveness, avg(valence) valence, avg(tempo) tempo from artists a join tracks t on t.artist_id = a.id join track_profiles tp on tp.track_id = t.id where artist_id = #{this.id} group by artist_id"
    ActiveRecord::Base.connection.exec_query(sql).to_hash
  end

  def genre_score(user)
    user.score_track_genres(genre_list)
  end

end
