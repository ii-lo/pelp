# == Schema Information
#
# Table name: materials
#
#  id                   :integer          not null, primary key
#  name                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  file_file_name       :string
#  file_content_type    :string
#  file_file_size       :integer
#  file_updated_at      :datetime
#  material_category_id :integer
#

require 'rails_helper'

RSpec.describe Material, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :name }

    it { is_expected.to validate_presence_of :material_category }
  end
end
