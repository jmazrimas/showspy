class RemoveNameAddTokensToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.remove :name
      t.string :access_token
      t.string :refresh_token
    end
  end
end
