class BotListener < ApplicationJob
  def perform
    TelegramBotApi.get_updates
  end
end