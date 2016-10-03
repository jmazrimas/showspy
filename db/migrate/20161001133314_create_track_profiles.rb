class CreateTrackProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :track_profiles do |t|
      t.integer :track_id
      t.float :danceability
      t.float :energy
      t.float :loudness
      t.float :mode
      t.float :speechiness
      t.float :acousticness
      t.float :instrumentalness
      t.float :liveness
      t.float :valence
      t.float :tempo
      t.timestamps
    end
  end
end
