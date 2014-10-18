require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PastelHelper. For example:
#
# describe PastelHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PastelHelper, :type => :helper do
  it "returns color for string" do
    regexp = /\A#[0-9a-f]{3,6}\z/i
    expect(helper.string_to_pastel("asdf")).to match regexp
    expect(helper.string_to_pastel("")).to match regexp
  end

  it "does not return other color for other string" do
    expect(helper.string_to_pastel("asdf")).not_to eq helper.string_to_pastel("asdfr1")
  end
end
