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

    #if Token.validate(request, errors)
      result["redirectUrl"] = Auth.getAuthCode
      redirect_to result["redirectUrl"]
    #else
      #give(result, errors)
    #end
  end

  def disconnectFromGoogle
    errors = []
    result = {}

    #if Token.validate(request, errors)
      Auth.revokeToken(request, result, errors)
    #end

    give(result, errors)
  end

  def connectToGoogleCallback
    errors = []
    result = {}

    #if Token.validate(request, errors)
      Auth.getToken(request, result, errors)
    #end

    give(result, errors)
  end

  def apiActionNotFound
    give({}, "apiActionNotFound");
  end

end
