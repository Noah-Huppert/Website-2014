module UrlHelper
  extend ActiveSupport::Concern

  def self.format(base, params)
    formatted = base
    i = 0
    params.each do |key, value|
      concater = "&"
      if i == 0
        concater = "?"
      end

      formatted += concater + key.to_s + "=" + value.to_s
      i += 1
    end#params.each

    return formatted
  end#format

end#UrlHelper
