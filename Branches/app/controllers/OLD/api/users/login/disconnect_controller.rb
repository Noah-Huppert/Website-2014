class Api::Users::Login::DisconnectController < ActionController::Base
  def index
    render plain: "GET /api/users/login/disconnect"
  end
end
