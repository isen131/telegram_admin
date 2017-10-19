class WhitelistMessagesController < ApplicationController
  helper_method :resource_messages_collection

  def index
  end

  protected

  def resource_messages_collection
    @resource_messages_collection ||= BotUser::Message.accepted
  end
end