class CreateVenues < ActiveRecord::Migration[5.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.integer :jambase_id
      t.timestamps
    end
  end
end
