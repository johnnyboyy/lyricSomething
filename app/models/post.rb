class Post < ActiveRecord::Base


  def convert_to_proper_url_format

    bad_url = self.link_url

    if /[www]/ === bad_url
      bad_url.prepend("http://")
    else
      bad_url.prepend("http://www.")
    end
    

  end
end
