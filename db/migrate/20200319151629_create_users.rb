class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :uid
      t.string :oauth_token
      t.string :oauth_expires_at

      t.timestamps
    end
  end
end
