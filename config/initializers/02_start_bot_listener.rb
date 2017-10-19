RedisMutex.with_lock("telegram_bot_listener") do
  BotListener.perform_async
end