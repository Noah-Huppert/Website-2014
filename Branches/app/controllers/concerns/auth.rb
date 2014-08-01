module Auth
  extend ActiveSupport::Concern

  #require "signet/oauth_2/client"
  #require "google/api_client"
  #require "google/api_client/auth/installed_app"
  require "rest_client"

  def self.leg1
=begin
    gapi_client = Google::APIClient.new(
      :application_name => "Branches",
      :application_version => "0.0.1")

    gapi_plus = gapi_client.discovered_api("plus")

    gapi_flow = Google::APIClient::InstalledAppFlow.new(
      :client_id => Rails.application.secrets.gapi_client_id,
      :client_secret => Rails.application.secrets.gapi_client_secret,
      :scope => ["https://www.googleapis.com/auth/plus.me"],
      :redirect_uri => Rails.application.secrets.gapi_redirect_uri)

    gapi_client.authorization = gapi_flow.authorize
=end
=begin
    oathClient = Signet::OAuth2::Client.new(
      :authorization_uri => "https://accounts.google.com/o/oauth2/auth",
      :token_credential_uri => "https://accounts.google.com/o/oauth2/token",
      :client_id => Rails.application.secrets.gapi_client_id,
      :client_secret => Rails.application.secrets.gapi_client_secret,
      :redirect_uri => Rails.application.secrets.gapi_redirect_uri,
      :scope => "https://www.googleapis.com/auth/plus.login")

    gapi_client = Google::APIClient.new(
      :application_name => "Branches",
      :application_version => "0.0.1")

    oathClient.code = request.body.read
    oathClient.fetch_access_token!
    gapi_client.authorization = oathClient

    return gapi_client.authorization.id_token
=end

    data = {
      :client_id => Rails.application.secrets.gapi_client_id,
      :redirect_uri => Rails.application.secrets.gapi_redirect_uri,
      :scope => "https://www.googleapis.com/auth/plus.login",
      :response_type => "code"
    }

    url = "https://accounts.google.com/o/oauth2/auth?"

    i = 0
    data.each do | key, value |
      beginer = "&"

      if i == 0
        beginer = ""
      end

      url = url + beginer + key.to_s + "=" + value.to_s
      i = i + 1
    end

    return url;

  end#leg1

  def self.leg2(request)
    code = request.params[:code]

    data = {
      :code => code,
      :client_id => Rails.application.secrets.gapi_client_id,
      :client_secret => Rails.application.secrets.gapi_client_secret,
      :redirect_uri => Rails.application.secrets.gapi_redirect_uri,
      :grant_type => "authorization_code"
    }

    url = "https://accounts.google.com/o/oauth2/token"

    response = RestClient.post url, data


    return response
  end#leg2


end#Auth
