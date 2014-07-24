class ApiController < ApplicationController

  include Token
  include Giver

  require 'google/api_client'

  def listUIDs
    errors = []
    result = {}

    if Token.validate(request, errors)
      result["valid"] = "true"
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


  def connectToGoogle
    render plain: "Connect to google"
  end

  def disconnectFromGoogle
    render plain: "Disconnect from google"
  end

  def connectToGoogleCallback
    render plain: "Connect to google callback"
  end

  def apiActionNotFound
    give({}, "apiActionNotFound");
  end

end
