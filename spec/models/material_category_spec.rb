# == Schema Information
#
# Table name: material_categories
#
#  id                 :integer          not null, primary key
#  lesson_category_id :integer
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe MaterialCategory, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :name }

    it { is_expected.to validate_presence_of :lesson_category }
  end
end
