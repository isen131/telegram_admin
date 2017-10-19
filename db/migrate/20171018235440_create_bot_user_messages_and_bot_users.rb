class CreateBotUserMessagesAndBotUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :bot_users do |t|
      t.integer :telegram_id
      t.string :first_name
      t.string :last_name
      t.string :username
      t.integer :last_template_id
      t.timestamps
    end

    create_table :bot_user_messages do |t|
      t.integer :bot_user_id
      t.integer :template_id
      t.text :punchline
      t.string :status
      t.timestamps
    end
  end
end
