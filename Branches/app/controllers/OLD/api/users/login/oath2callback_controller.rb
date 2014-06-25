class Api::Users::Login::Oath2callbackController < ActionController::Base
  def index
    redirect_to "http://www.google.com"
    #render plain: "GET /api/users/login/oath2callback"
  end
end
