require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe HeaderUploader do
  include CarrierWave::Test::Matchers

  before do
    @course = FactoryGirl.create :course
    HeaderUploader.enable_processing = true
    @uploader = HeaderUploader.new(@course, :header)
    @uploader.store!(File.open(File.expand_path('../Sydney-harbour-bei-nacht-wallpaper.JPG', __FILE__)))
  end

  after do
    HeaderUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the thumb version' do
    it "should scale down a landscape image to be exactly 64 by 64 pixels" do
      expect(@uploader.thumb).to have_dimensions(64, 64)
    end
  end

  context 'the small version' do
    it "should scale down a landscape image to fit within 200 by 200 pixels" do
      expect(@uploader.large).to have_dimensions(1170, 128)
    end
  end
end
