namespace :bot do
  
  task start_listener: :environment do
    TelegramBotApi.get_updates
  end

end