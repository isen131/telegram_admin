class Auth::SessionsController < ApplicationController
  before_filter :require_not_persisted_user, :except => [:destroy]

  skip_filter :store_return_to
  skip_filter :require_persisted_user, :except => [:destroy]

  helper_method :resource_session

  def new
  end

  def create
    if self.create_session(session_params)
      redirect_to root_url
    else
      render :action => :new
    end
  end

  def destroy
    User::Session.find(:public).destroy
    redirect_to root_url
  end

protected

  def resource_session
    @session ||= User::Session.new
  end

  def session_params
    params.fetch(:session, {}).permit(:login, :password)
  end

end
