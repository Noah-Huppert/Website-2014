module USession
  extend ActiveSupport::Concern

  def self.generate
    session = {
      :sid => SecureRandom.uuid,
      :secret => SecureRandom.hex(32),
      :expires_on => DateTime.now + 1209600.seconds
    }

    return session
  end#generate

  def self.create(user)
    session = self.generate

    if self.isSessionUnique(session)
      UserSession.create(user_gid: user.gid, sid: session[:sid], secret: session[:secret], expires_on: session[:expires_on])
    else
      self.create(user)
    end

    return session
  end

  def self.isSessionUnique(session)
    sidUnique = false
    secretUnique = false
    isUnique = false

    if UserSession.find_by(sid: session[:sid]).nil?
      sidUnique = true
    end

    if UserSession.find_by(secret: session[:secret]).nil?
      secretUnique = true
    end

    if sidUnique && secretUnique
      isUnique = true
    end

    return isUnique
  end
end#USession
