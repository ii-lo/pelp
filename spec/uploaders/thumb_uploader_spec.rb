require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe ThumbUploader do
  include CarrierWave::Test::Matchers

  before do
    @course = FactoryGirl.create :course
    ThumbUploader.enable_processing = true
    @uploader = ThumbUploader.new(@course, :header)
    @uploader.store!(File.open(File.expand_path('../Sydney-harbour-bei-nacht-wallpaper.JPG', __FILE__)))
  end

  after do
    ThumbUploader.enable_processing = false
    @uploader.remove!
  end

  it "scales down a landscape image to be exactly 64 by 64 pixels" do
    expect(@uploader).to have_dimensions(64, 64)
  end
end
