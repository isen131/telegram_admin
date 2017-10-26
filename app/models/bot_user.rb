class BotUser < ApplicationRecord
  has_many :messages, class_name: 'BotUser::Message'
end