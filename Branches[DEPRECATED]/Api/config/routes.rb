Rails.application.routes.draw do
  #root 'index'


  get '/api/users', to: 'api#listUIDs'
  post '/api/users', to: 'api#newUser'

  get '/api/users/u/:uid', to: 'api#getUser'
  delete '/api/users/u/:uid', to: 'api#deleteUser'

  get '/api/users/u/:uid/:aid', to: 'api#getAttribute'
  patch '/api/users/u/:uid/:aid', to: 'api#updateAttribute'
  put '/api/users/u/:uid/:aid', to: 'api#updateAttribute'

  get '/api/tokens/t/:token', to: 'api#validateToken'
  get '/api/tokens/n', to: 'api#createToken'
  delete '/api/tokens/t/:token', to: 'api#deleteToken'

  get '/api/users/login/connect', to: 'api#connectToGoogle'
  get '/api/users/login/disconnect', to: 'api#disconnectFromGoogle'
  get '/api/users/login/oauth2callback', to: 'api#connectToGoogleCallback'


  get '/api/test/simLogin', to: 'api#simLogin'

  #namespace :api do
  #  resources :users, only: [:index, :create]
  #  namespace :users do
  #    resources :u, only: [:show, :destroy] do
  #      resources :a, only: [:show, :update]
  ##    end#u
  #    namespace :login do
  #      resources :connect, only: [:index]
  #      resources :disconnect, only: [:index]
  #      resources :oath2callback, only: [:index]
  #    end#login
  #  end#users
  #  match "*path", to: "users#apiActionNotFound", via: :all#Handle all not defined
  #end#api

  #HTTP VERBS: GET => :index, POST => :create, PATCH => :update, PUT => :update, DELETE => :destroy
end
