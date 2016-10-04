class CreateTopArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :top_artists do |t|
      t.integer :user_id
      t.integer :artist_id
      t.timestamps
    end
  end
end
