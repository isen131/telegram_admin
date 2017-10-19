class BotListener
  include Sidekiq::Worker
  
  def perform
    TelegramBotApi.get_updates
  end
end