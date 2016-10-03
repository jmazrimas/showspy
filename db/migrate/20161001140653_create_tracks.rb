class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.string :spotify_id
      t.integer :artist_id
      t.timestamps
    end
  end
end
