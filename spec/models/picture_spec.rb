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

require 'rails_helper'

RSpec.describe Picture, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :lesson_id }
  end

  describe '#set_slug' do
    it "sets slug" do
      pic = FactoryGirl.build :picture
      expect(pic.slug).to be_blank
      pic.save
      expect(pic.slug).to be_present
    end
  end
end
