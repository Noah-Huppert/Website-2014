module ViewHelpers
  extend ActiveSupport::Concern

  def self.site
    site = {
      :url => "http://127.0.0.1:3000/",
      :scripts_path => "script/",
      :styles_path => "style/",
      :bower_path => "bower/"
    }

    return site
  end

end#ViewHelpers
