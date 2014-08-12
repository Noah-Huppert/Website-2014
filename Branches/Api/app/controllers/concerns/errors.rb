module Errors
  extend ActiveSupport::Concern

  def self.createError(errorId, errorDesc)
    id = "Not available"
    desc = "Not available"

    if defined?(errorId)
      id = errorId
    end

    if defined?(errorDesc)
      desc = errorDesc
    end

    errorObj = {
      "id" => id,
      "desc" => errorDesc
    }

    return errorObj
  end#createError

  def self.error(errorId)
    returnError = createError(nil, nil)

    case errorId
    when "badRequestToken"
      returnError = createError(errorId, "The request token provided is not valid")
    when "apiActionNotFound"
      returnError = createError(errorId, "The API action requested does not exist")
    when "noRefreshTokenOnGAPITokenCreate"
      returnError = createError(errorId, "A refresh_token was not returned by the GAPI, this is needed for GAPIToken creation")
    when "badGAPIRequest"
      returnError = createError(errorId, "The request to GAPI returned a bad result")
    when "badRequest"
      returnError = createError(errorId, "The request parameters sent do not match the required parameters")
    when "noSuchUser"
      returnError = createError(errorId, "The user given to perform the action on does not exist")
    when "userLacksGapiToken"
      returnError = createError(errorId, "The specified user does not have a gapiToken, try loging the user in")
    end

    return returnError
  end#error

  def self.errors(errorsList, asJsonElement = false)

    requestedErrorIds = errorsList.split(" ")
    requestedErrors = []

    requestedErrorIds.each {
      |errorId|
      requestedErrors.push(error(errorId))
    }

    if asJsonElement
      errorsObject = {
        "errors" => requestedErrors
      }
    else
      errorsObject = requestedErrors
    end

    return errorsObject
  end#errors

end#Errors
