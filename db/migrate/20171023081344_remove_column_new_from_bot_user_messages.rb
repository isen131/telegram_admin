class RemoveColumnNewFromBotUserMessages < ActiveRecord::Migration[5.0]
  def change
    remove_column :bot_user_messages, :new
  end
end
