class Post < ActiveRecord::Base

  validates :lyric, :artist, presence: true

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

  def correct_link_url
    if /.\.com\/./ === link_url
      self.convert_to_proper_url_format
      url_is_the_proper_format
    elsif is_not_playlist? == false
      link_url = link_url.split("&list")[0]
      url_is_the_proper_format
    else
      errors.add(:link_url, "The URL is not valid.")
    end
  end


  def url_is_the_proper_format
    if link_url.present? && url_is_valid? && is_not_playlist?
      return true
    else
      correct_link_url
    end
  end

  def is_not_playlist?
    /[&list]/ === link_url
  end


  def convert_to_proper_url_format
    
    if /^+[www]+\./ === self.link_url
      self.link_url = self.link_url.prepend("http://")
    elsif /^+[http:]/
      break
    elsif /^+[https:]/
      break
    else
      self.link_url = self.link_url.prepend("http://www.")
    end


  end


  def embed_url
    url = self.link_url

    if /youtube/ === url
      url.gsub!("watch?v=", "embed/")
    end

    return "/" + url[7..-1]
  end
end
