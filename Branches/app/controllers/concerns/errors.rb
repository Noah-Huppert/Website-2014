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
