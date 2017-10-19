class UnsortedMessagesController < ApplicationController
  helper_method :resource_messages_collection

  def index
  end

  def accept
    resource_message.accept!
    render partial: 'shared/js/content', locals: {
      replace: '@unsortedMessagesList',
      with: 'unsorted_messages/shared/list',
      locals: {
        resource_messages_collection: resource_messages_collection
      }
    }
  end

  def reject
  end

  def reload_collection
    
  end

  protected

  def resource_messages_collection
    @resource_messages_collection ||= BotUser::Message.unsorted
  end

  def resource_message
    @resource_message ||= BotUser::Message.find(params[:id])
  end

end