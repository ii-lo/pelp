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

  it "scales down a landscape image to be exactly 1170 by 128 pixels" do
    expect(@uploader).to have_dimensions(1170, 128)
  end
end
