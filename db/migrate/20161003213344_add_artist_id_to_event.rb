class AddArtistIdToEvent < ActiveRecord::Migration[5.0]
  def change
    change_table :events do |t|
      t.integer :artist_id
    end
  end
end
