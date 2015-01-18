# == Schema Information
#
# Table name: pictures
#
#  id                :integer          not null, primary key
#  slug              :string
#  description       :string           default("")
#  lesson_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#

class Picture < ActiveRecord::Base
  before_create :set_slug
  belongs_to :lesson

  validates :lesson_id, presence: true
  has_attached_file :file
  validates_attachment :file, presence: true, content_type:{
    content_type: /\Aimage\/.*\Z/
  }

  def set_slug
    begin
      self.slug = SecureRandom.urlsafe_base64
    end while Picture.exists?(slug: self.slug)
  end

  private

  def method_missing(method, *arguments, &block)
    self.file.send(method, *arguments, &block)
  rescue
    super
  end
end
