class ApplicationController < ActionController::Base
  include AuthlogicMethods

  layout 'application'
  protect_from_forgery with: :exception

  def create_session(user)
    @session = User::Session.new(user)
    @session.remember_me = true
    @session.id = :public
    @session.save
  end

end
