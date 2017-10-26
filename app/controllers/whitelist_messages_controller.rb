class WhitelistMessagesController < ApplicationController
  helper_method :resource_messages_collection
  skip_filter :require_persisted_user, only: [:get_messages]

  def index
  end

  def get_messages
    if params[:token].blank? || params[:token] != 'wmbe2W_fAssrA3oG55ulOQ'
      render :nothing => true
    else
      render json: { :messages => resource_messages_collection.map {|m|
          {
            :name => m.bot_user.username,
            :template => m.template.text,
            :punchline => m.punchline
          }
        }
      }
    end
  end

  def get_templates
    if params[:token].blank? || params[:token] != 'wmbe2W_fAssrA3oG55ulOQ'
      render :nothing => true
    else
      render json: { :templates => Template.all.map {|t|
          {
            :text => t.text
          }
        }
      }
    end
  end

  def reject
    resource_message.reject!
    render partial: 'shared/js/content', locals: {
      replace: '@whitelistMessagesList',
      with: 'whitelist_messages/shared/list',
      locals: {
        resource_messages_collection: resource_messages_collection
      }
    }
  end

  protected

  def resource_messages_collection
    @resource_messages_collection ||= BotUser::Message.accepted
  end

  def resource_message
    @resource_message ||= BotUser::Message.find(params[:id])
  end
  
end