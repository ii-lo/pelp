module UrlHelper
  def pretty_url(url)
    url.sub!(/https?\:\/\//, '')
  end
end
