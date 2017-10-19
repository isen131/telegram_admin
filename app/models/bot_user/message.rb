class BotUser::Message < ApplicationRecord
  include AASM

  belongs_to :bot_user
  belongs_to :template, class_name: 'Template'

  aasm column: :status, whiny_transitions: false do
    state :unsorted, initial: true
    state :accepted
    state :rejected

    event :accept do
      transitions to: :accepted
    end

    event :reject do
      transitions to: :rejected
    end
  end

  def text
    return if self.template.blank? || self.punchline.blank?

    "#{self.template.text} #{self.punchline.strip}"
  end
end