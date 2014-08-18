class Post < ActiveRecord::Base


  validate :url_is_the_proper_format


  def url_is_valid?

    if /^http:\/\/+www+\.+(\w|\W)+\./ === link_url
      return true
    elsif /^https:\/\/+www+\.+(\w|\W)+\./ === link_url
      return true
    else
      return false
    end

  end


  def url_is_the_proper_format
    if link_url.present? && url_is_valid?
      return true
    else
      if /.\.com\/./ === lyic.link_url
        self.convert_to_proper_url_format
      else          
        errors.add(:link_url, "The URL is not valid.")
      end
    end
  end


  def convert_to_proper_url_format
    
    if /^+[www]+\./ === self.link_url
      self.link_url = self.link_url.prepend("http://")
    else
      self.link_url = self.link_url.prepend("http://www.")
    end


  end
end
