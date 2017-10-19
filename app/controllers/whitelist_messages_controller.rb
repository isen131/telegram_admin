class WhitelistMessagesController < ApplicationController
  helper_method :resource_messages_collection
  skip_filter :require_persisted_user, only: [:get_messages]

  def index
  end

  def get_messages
    if params[:token].blank? || params[:token] != 'wmbe2W_fAssrA3oG55ulOQ'
      render :nothing => true
    else
      render json: { :messages => resource_messages_collection.to_json }
    end
  end

  protected

  def resource_messages_collection
    @resource_messages_collection ||= BotUser::Message.accepted
  end
end