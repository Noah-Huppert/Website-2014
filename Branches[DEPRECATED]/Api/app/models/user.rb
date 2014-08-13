class User < ActiveRecord::Base
  has_many :user_sessions
  has_one :api_token
end
