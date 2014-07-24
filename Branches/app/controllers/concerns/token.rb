module Token
  extend ActiveSupport::Concern

  #def self.valid(givenRequestToken)
  #end

  def self.create(permissions)
    #token => SecureRandom.uuid
    #secret => SecureRandom.hex(32)
    #permissions => ""
    # Permissions:
    # => admin

    requestToken = {
      :token => SecureRandom.uuid,
      :secret => SecureRandom.hex(32),
      :permissions => permissions
    }

    RequestToken.create(token: requestToken[:token], secret: requestToken[:secret], permissions: requestToken[:permissions])

    return requestToken
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
