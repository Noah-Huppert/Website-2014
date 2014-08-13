module Giver
  extend ActiveSupport::Concern

  include Errors

  def give(payload, errors)

    if !defined?(payload) || payload == nil
      payload = {}
    end

    if !defined?(errors) || errors == nil
      errors = ""
    end

    if errors.kind_of? Array
      errors = errors.join(" ")
    end

    sendObject = payload
    sendObject["errors"] = Errors.errors(errors)

    render json: JSON.pretty_generate(sendObject)

  end#give

end#Sender
