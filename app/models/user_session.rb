class UserSession < Authlogic::Session::Base
  password_field :access_token
  verify_password_method :valid_access_token
end
