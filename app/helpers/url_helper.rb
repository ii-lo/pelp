module UrlHelper
  def pretty_url(url)
    url.sub!(%r{https?\:\/\/}i, '')
  end
end
