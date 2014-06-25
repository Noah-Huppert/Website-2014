class Api::Users::Login::ConnectController < ActionController::Base
  def index
    render plain: "GET /api/users/login/connect"
  end
end
