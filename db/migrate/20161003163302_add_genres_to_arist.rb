class AddGenresToArist < ActiveRecord::Migration[5.0]
  def change
    change_table :artists do |t|
      t.string :genre_list
    end
  end
end
