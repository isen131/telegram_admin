class TelegramBotApi
  require 'telegram/bot'
  TELEGRAM_TOKEN = Rails.env.production? ? '387173014:AAGWNVqr2CaNN3hi7DWM_p3mOSku-Nixuvw' : '428559215:AAFwkErv6EoczhTiNwj4JPyYbSdhIDNc6fs'

  class << self

    def get_updates
      Telegram::Bot::Client.run(TELEGRAM_TOKEN) do |bot|
        bot.listen do |message|
          promoter = Promoter.find_by(telegram_id: message.from.id)
          if promoter.blank?
            promoter = Promoter.create(
              telegram_id: message.from.id,
              current_bot_user: nil
            )
          end

          case message
          when Telegram::Bot::Types::CallbackQuery

            if message.data == 'cancel'
              promoter.update_column(:current_bot_user, nil)
              promoter.update_column(:command, 'new_user')
              bot.api.send_message(chat_id: message.from.id, text: "Введите имя или псевдоним участника")
            elsif promoter.command == 'choose_template'
              bot_user = BotUser.find(promoter.current_bot_user)
              bot_user.update_column(:last_template_id, message.data.split[1].to_i)
              template = Template.find(message.data.split[1].to_i)
              kb = Telegram::Bot::Types::InlineKeyboardButton.new(text: "Отмена", callback_data: "cancel")
              markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
              bot.api.send_message(chat_id: message.from.id, text: "Продолжите фразу: «#{template.text}...»", reply_markup: markup)
              promoter.update_column(:command, 'new_punchline')
            end
          when Telegram::Bot::Types::Message
            
            if promoter.command == 'new_user'
              bot_user = BotUser.create(username: message.text)
              promoter.update_column(:current_bot_user, bot_user.id)
              kb = Template.all.map {|t| Telegram::Bot::Types::InlineKeyboardButton.new(text: "#{t.text}...", callback_data: "template #{t.id}")}
              kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: "Отмена", callback_data: "cancel")
              markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
              promoter.update_column(:command, 'choose_template')
              bot.api.send_message(chat_id: message.chat.id, text: 'Какую фразу вы бы хотели продолжить?', reply_markup: markup)
            elsif promoter.command.blank? || promoter.current_bot_user.blank?
              promoter.update_column(:command, 'new_user')
              bot.api.send_message(chat_id: message.from.id, text: "Введите имя или псевдоним участника")
            elsif promoter.command == 'new_punchline'
              bot_user = BotUser.find(promoter.current_bot_user)
              bot_user.messages.create(template_id: bot_user.last_template_id, punchline: message.text)
              promoter.update_column(:current_bot_user, nil)
              promoter.update_column(:command, 'new_user')
              bot.api.send_message(chat_id: message.from.id, text: "Ваш ответ отправлен. Спасибо за участие.")
              bot.api.send_message(chat_id: message.from.id, text: "Введите имя или псевдоним участника")
            else
              if promoter.command == 'choose_template'
                kb = Template.all.map {|t| Telegram::Bot::Types::InlineKeyboardButton.new(text: "#{t.text}...", callback_data: "template #{t.id}")}
                kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: "Отмена", callback_data: "cancel")
                markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
                bot.api.send_message(chat_id: message.from.id, text: "Пожалуйста, выберите фразу или нажмите «Отмена»", reply_markup: markup)
              else
                promoter.update_column(:current_bot_user, nil)
                promoter.update_column(:command, 'new_user')
                bot.api.send_message(chat_id: message.from.id, text: "Введите имя или псевдоним участника")
              end
            end

          end
        end
      end
    end

    def get_updates1
      Telegram::Bot::Client.run(TELEGRAM_TOKEN) do |bot|
        bot.listen do |message|
          bot_user = BotUser.find_by(telegram_id: message.from.id)
          if bot_user.blank?
            bot_user = BotUser.create(
              telegram_id: message.from.id,
              first_name: message.from.first_name,
              last_name: message.from.last_name,
              username: message.from.username
            )
          end

          if bot_user.last_template_id.present?
            bot_user.messages.create(template_id: bot_user.last_template_id, punchline: message.text)
          end

          template = Template.order('RANDOM()').first
          reply_text = "Продолжите фразу: «#{template.text}...»"
          bot_user.update_column(:last_template_id, template.id)

          case message.text
          when '/start'
            bot.api.send_message(chat_id: message.chat.id, text: reply_text)
          else
            bot.api.send_message(chat_id: message.chat.id, text: "Ваше сообщение отправлено.\r\n \r\n#{reply_text}")
          end
        end
      end
    end

    def get_updates2
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