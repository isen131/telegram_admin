class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.index  :persistence_token, unique: true
      t.timestamps
    end
  end
end
