class User::Session < Authlogic::Session::Base
  authenticate_with User

  last_request_at_threshold 1.minute

  find_by_login_method :find_by_lowercase_login

end
