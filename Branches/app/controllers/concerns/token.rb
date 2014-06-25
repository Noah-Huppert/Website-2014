module Token
  extend ActiveSupport::Concern

  def self.valid(requestToken)
    return true
  end

  def self.create
    return SecureRandom.uuid
  end

  def self.validate(request, errors)

    isValid = true
    requestToken = request.headers["requestToken"].to_s

    if !self.valid(requestToken)#Check the requestToken's authenticity
      errors.push("badRequestToken")
      isValid = false
    end

    return isValid
  end#validate

end#RequestToken
