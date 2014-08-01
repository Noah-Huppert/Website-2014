class ApiController < ApplicationController

  include Token
  include Giver
  include Auth

  require 'google/api_client'

  def listUIDs
    errors = []
    result = {}

    if Token.validate(request, errors)
      result["uuids"] = "true"
    end

    give(result, errors)
  end

  def newUser
    #gplus_id
    give({}, nil)
  end

  def getUser
    give({}, nil)
  end

  def deleteUser
    give({}, nil)
  end

  def getAttribute
    give({}, nil)
  end

  def updateAttribute
    give({}, nil)
  end


  def validateToken

  end

  def createToken
    result = {}
    errors = []
    #if Rails.env.development?
      permissions = request.headers["requestTokenPermissions"]
      result["requestToken"] = Token.create(permissions)
    #end

    give(result, errors);
  end

  def deleteToken

  end


  def connectToGoogle
    errors = []
    result = {}

    if Token.validate(request, errors)
      result["leg1"] = Auth.leg1
    end

    redirect_to result["leg1"]
  end

  def disconnectFromGoogle
    render plain: "Disconnect from google"
  end

  def connectToGoogleCallback
    errors = []
    result = {}

    if Token.validate(request, errors)
      result["leg2"] = Auth.leg2(request)
    end

    give(result, errors)
  end

  def apiActionNotFound
    give({}, "apiActionNotFound");
  end

end
