class Api::Users::UController < ActionController::Base
  def show
    render plain: "GET /api/users/u/:uid"
  end

  def destroy
    render plain: "DELETE /api/users/u/:uid"
  end
end
