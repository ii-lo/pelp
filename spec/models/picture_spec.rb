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
    it { is_expected.to validate_presence_of :lesson }
  end

  describe '#set_slug' do
    it "sets slug" do
      pic = FactoryGirl.build :picture
      allow(pic).to receive(:lesson) { Lesson.new }
      expect(pic.slug).to be_blank
      pic.save
      expect(pic.slug).to be_present
    end
  end

  describe '#method missing' do
    it 'reponds to files methods' do
      pic = FactoryGirl.build :picture
      expect(pic).to respond_to :url
      expect(pic.url).to eq pic.file.url
      expect { pic.asdfff }.to raise_error
    end
  end
end
