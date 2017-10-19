class TelegramBotApi
  TELEGRAM_TOKEN = '428559215:AAFwkErv6EoczhTiNwj4JPyYbSdhIDNc6fs'

  class << self

    def init_bot
      
    end

    def get_updates
      bot = TelegramBot.new(token: TELEGRAM_TOKEN)
      # begin
        bot.get_updates(fail_silently: true) do |message|
          bot_user = BotUser.find_by(telegram_id: message.from.id)
          if bot_user.blank?
            BotUser.create(
              telegram_id: message.from.id,
              first_name: message.from.first_name,
              last_name: message.from.last_name,
              username: message.from.username
            )
          end

          bot_user.messages.create(template_id: bot_user.last_template_id, punchline: message.text)

          command = message.get_command_for(bot)

          message.reply do |reply|
            case command
            when /start/i
              
            else
              # reply.text = "#{message.from.first_name}, have no idea what #{command.inspect} means."
            end

            template = Template.order('RANDOM()').first
            reply.text = "Продолжите фразу: «#{template.text}...»"
            bot_user.update_column(:last_template_id, template.id)

            puts "sending #{reply.text.inspect} to @#{message.from.username}"
            reply.send_with(bot)
          end
        end
      # rescue
      # end
    end
    
  end
end