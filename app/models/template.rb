class Template < ApplicationRecord
  has_many :bot_user_messages, class_name: 'BotUser::Message'
end