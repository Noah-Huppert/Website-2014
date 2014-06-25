class Api::Users::AController < ActionController::Base
  def show
    render plain: "GET /api/users/u/:uid/a/:attr"
  end

  def update
    render plain: "PATCH/PUT /api/users/u/:uid/a/:attr"
  end
end
