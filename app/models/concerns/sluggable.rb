module Sluggable
  extend ActiveSupport::Concern
  included do
    before_create :set_slug
  end

  def set_slug
    begin
      self.slug = SecureRandom.urlsafe_base64
    end while self.class.exists?(slug: self.slug)
  end
end
