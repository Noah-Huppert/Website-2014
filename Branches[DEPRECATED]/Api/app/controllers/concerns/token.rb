module Token
  extend ActiveSupport::Concern

  #def self.valid(givenRequestToken)
  #end

  def self.create(permissions = "")
    #token => SecureRandom.uuid
    #secret => SecureRandom.hex(32)
    #permissions => ""
    # Permissions:
    # => admin

    requestToken = self.genToken(permissions)

    if self.isTokenUnique(requestToken[:token])
      RequestToken.create(token: requestToken[:token], secret: requestToken[:secret], permissions: requestToken[:permissions])
    else
      self.create(permissions)
    end

    return requestToken
  end

  def self.genToken(permissions)
    requestToken = {
      :token => SecureRandom.uuid,
      :secret => SecureRandom.hex(32),
      :permissions => permissions
    }

    return requestToken
  end#genToken

  def self.isTokenUnique(token)
    requestToken = RequestToken.find_by token: token
    return requestToken.nil?
  end

  def self.validate(request, errors, requiredPermissions = "")

    isValid = false;

    #Token Parts
    gRequestToken = {
      :token => request.headers["requestToken"],
      :secret => request.headers["requestTokenSecret"]
    }
    gPermissions = requiredPermissions.split(" ")


    qRequestToken = RequestToken.find_by token: gRequestToken[:token]


    #Validate Token and Secret
    if !qRequestToken.nil? && gRequestToken[:token].eql?(qRequestToken.token) && gRequestToken[:secret].eql?(qRequestToken.secret)
      #Valid, check permisions
      hasPermissions = true
      qPermissions = qRequestToken.permissions.split(" ")

      for permission in gPermissions
        if !qPermissions.include? permission
          hasPermissions = false
        end
      end

      isValid = hasPermissions
    else
      #Invalid
      errors.push("badRequestToken")
    end


    return isValid
  end#validate

end#RequestToken
