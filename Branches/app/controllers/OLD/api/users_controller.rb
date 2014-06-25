class Api::UsersController < ActionController::Base
  def index
    render plain: "GET /api/users"
  end

  def new
    render plain: "POST /api/users"
  end

  def apiActionNotFound
    response = {
      :errors [
        {
          :id => "apiActionNotFound",
          :description => "An Api action for this address was not found"
        }
      ]
    }
    
    render json: response
  end
end
