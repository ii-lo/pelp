# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#

require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { User.new }
  describe 'validation' do
    it { is_expected.to validate_presence_of :email }

    it { is_expected.to validate_presence_of :name }

    it { is_expected.to validate_uniqueness_of :email }
  end

  describe '#last_visited_courses' do
    before do
      FactoryGirl.create :user
      FactoryGirl.create :course
      Attending.create(course_id: 1, user_id: 1)
      FactoryGirl.create :course
      Attending.create(course_id: 2, user_id: 1)
    end

    it "is equal to last visited courses" do
      expect(User.first.last_visited_courses).to(
        eq [Course.last, Course.first]
      )
    end

    context "update last_visited" do
      before do
        Attending.first.update_last_visited
      end

      it "is equal to last visited courses" do
        expect(User.first.last_visited_courses).to(
          eq [Course.first, Course.last]
        )
      end
    end

    context "param" do
      before do
        3.upto(5) do |n|
          FactoryGirl.create :course
          Attending.create(course_id: n, user_id: 1)
        end
      end

      it "return n courses" do
        expect(User.first.last_visited_courses(5).length).to eq 5
        expect(User.first.last_visited_courses(5)).to(
          eq User.first.last_visited_courses.first(5)
        )
      end
    end
  end
end
