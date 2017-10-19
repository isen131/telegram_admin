class BotUser < ApplicationRecord
  has_many :messages, class_name: 'BotUser::Message'

  def full_name
    [self.first_name, self.last_name].join(' ').strip
  end
end