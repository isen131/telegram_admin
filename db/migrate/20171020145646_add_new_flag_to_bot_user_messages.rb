class AddNewFlagToBotUserMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :bot_user_messages, :new, :boolean, default: :true, null: false
  end
end
