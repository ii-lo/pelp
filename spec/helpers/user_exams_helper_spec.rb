require 'rails_helper'

RSpec.describe UserExamsHelper, :type => :helper do
  it "returns correct string" do
    expect(helper.time_from_seconds(60)).to eq "1:00"
    expect(helper.time_from_seconds(2700)).to eq "45:00"
    expect(helper.time_from_seconds(2730)).to eq "45:30"
    expect(helper.time_from_seconds(2705)).to eq "45:05"
  end
end
