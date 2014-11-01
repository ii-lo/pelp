# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  topic       :string(255)
#  body        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Message, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :sender_id }

    it { is_expected.to validate_presence_of :receiver_id }

    it { is_expected.to validate_presence_of :topic }

    it { is_expected.to validate_presence_of :topic }
  end

end
