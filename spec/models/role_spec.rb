# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Role, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :name }
  end
  describe 'respondind' do
    it { is_expected.to respond_to :attendings }
  end
end