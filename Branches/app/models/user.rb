class User < ActiveRecord::Base
  has_many :user_sessions
  has_one :gapi_token
end
