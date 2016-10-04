class AddTokenExpiresToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.timestamp :token_expires_at
    end
  end
end
