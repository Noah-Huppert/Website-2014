module Auth
  extend ActiveSupport::Concern

  require "rest_client"

  include UrlHelper
  include USession

  def self.simLogin(result, errors)
    #Sample Data
    rToken = {
      :access_token => "Access Token",
      :refresh_token => "Refresh Token",
      :token_type => "Token Type",
      :expires_in => 3000,
      :expires_on => DateTime.now + 3000.seconds,
      :google_id => "Google Id"
    }

    #Attempt to find existing user
    @user = User.find_by(google_id: rToken[:google_id])

    if @user.nil?
      #If user not found, make new user
      @user = User.create(google_id: rToken[:google_id], permissions: "")
    end#@user.nil?

    result[:Created_or_Found_user] = @user.inspect
    result[:Querried_user] = User.find_by(google_id: rToken[:google_id]).inspect


    #Attempt to find existing gapi_token
    @gapi_token = @user.create_gapi_token
  end#self.simLogin

  def self.getAuthCodeUrl

    data = {
      :client_id => Rails.application.secrets.gapi_client_id,
      :redirect_uri => Rails.application.secrets.gapi_redirect_uri,
      :scope => "https://www.googleapis.com/auth/plus.login",
      :access_type => "offline",
      :response_type => "code"
    }

    url = "https://accounts.google.com/o/oauth2/auth"

    return UrlHelper.format(url, data)
  end#getAuthCode

  def self.getToken(request, toReturn, errors)
    code = request.params[:code]

    data = {
      :code => code,
      :client_id => Rails.application.secrets.gapi_client_id,
      :client_secret => Rails.application.secrets.gapi_client_secret,
      :redirect_uri => Rails.application.secrets.gapi_redirect_uri,
      :grant_type => "authorization_code"
    }

    url = "https://accounts.google.com/o/oauth2/token"

    RestClient.post(url, data){| response, request, result, &block |
        if response.code == 200
          responseData = JSON.parse response.body

          retrievedToken = {
            :access_token => responseData["access_token"],
            :refresh_token => responseData["refresh_token"],
            :token_type => responseData["token_type"],
            :expires_in => responseData["expires_in"].to_i,
            :expires_on => DateTime.now + responseData["expires_in"].to_i.seconds,
            :gid => responseData["id_token"]
          }

          #Check to make sure all mandatory parameters exist
          if retrievedToken[:access_token].nil? ||
             retrievedToken[:token_type].nil? ||
             retrievedToken[:expires_in].nil? ||
             retrievedToken[:expires_on].nil? ||
             retrievedToken[:gid].nil?

             errors.push("badGAPIRequest")
             break
          end#Check for mandatory params


          @user = User.find_by(gid: retrievedToken[:gid])

          if @user.nil?
            #Create user
            @user = User.create(gid: retrievedToken[:gid], permissions: "")
          end#user.nil?

          #Now that their is gaurenteed to be a user, check for a gapiToken
          @gapiToken = GapiToken.find_by(user_gid: @user.gid)

          toReturn["nilcheck"] =
          if @gapiToken.nil?
            #Create gapiToken
            if retrievedToken[:refresh_token].nil?
              #If no refresh token exit with error
              errors.push("noRefreshTokenOnGAPITokenCreate")
              break
            end#refresh_token.nil?

            @gapiToken = GapiToken.create(
              user_gid: @user.gid,
              access_token: retrievedToken[:access_token],
              token_type: retrievedToken[:token_type],
              expires_on: retrievedToken[:expires_on],
              refresh_token: retrievedToken[:refresh_token])
        else
          #Update refresh
          @gapiToken.update(
            access_token: retrievedToken[:access_token],
            token_type: retrievedToken[:token_type],
            expires_on: retrievedToken[:expires_on])
        end#gapiToken.nil?


        #Manage Sessions
        @userSessions = UserSession.all
        @validUserSession = nil

        #Delete old sessions
        @userSessions.each do | session |
          if DateTime.now > session.expires_on
            #Session has expired, delete
            session.destroy
          else
            @validUserSession = session
          end#Expire check
        end#userSessions.each

        if @validUserSession.nil?
          #No valid sessions, create one
          @validUserSession = USession.create(@user)
        end#validUserSession.nil?


        #Return data
        toReturn["getToken"] = {
          :retrievedToken => retrievedToken,
          :gapiToken => @gapiToken.inspect,
          :userSession => @validUserSession.inspect
        }

      else#else code
        errors.push("badGAPIRequest")
        toReturn["badResponse"] = JSON.parse response.body
      end#if code 200

    }#post
  end#getToken

  def self.revokeToken(request, toReturn, errors)
    gid = request.params["gid"]

    if gid.nil?
      errors.push("badRequest")
      return
    end

    @user = User.find_by(gid: gid)

    if @user.nil?
      errors.push("noSuchUser")
    end

    @gapiToken = GapiToken.find_by(user_gid: @user.gid)

    if @gapiToken.nil?
      errors.push("userLacksGapiToken")
      return
    end

    data = {
      :token => @gapiToken.refresh_token
    }

    url = "https://accounts.google.com/o/oauth2/revoke"
    finalUrl = UrlHelper.format(url, data)

    RestClient.get(finalUrl){| response, request, result, &block |
      if response.code == 200
          toReturn["success"] = "true"
      else
        errors.push("badGAPIRequest")
        toReturn["success"] = "false"
      end
    }#get
  end#revokeToken

end#Auth
