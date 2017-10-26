class CreatePromoters < ActiveRecord::Migration[5.0]
  def change
    create_table :promoters do |t|
      t.integer :telegram_id
      t.integer :current_bot_user
      t.string  :command
    end
  end
end
