# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  accepted   :boolean          default("f")
#

require 'rails_helper'

RSpec.describe Invitation, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :course }

    it { is_expected.to validate_presence_of :user }

    it { is_expected.to validate_presence_of :email }
  end
end
