class AddGenresToArist < ActiveRecord::Migration[5.0]
  def change
    change_table :artists do |t|
      t.string :genres
    end
  end
end
