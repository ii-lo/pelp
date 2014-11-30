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
      Attending.create(course_id: 1, user_id: 1, role_id: 1)
      FactoryGirl.create :course
      Attending.create(course_id: 2, user_id: 1, role_id: 1)
    end

    it "is equal to last visited courses" do
      expect(User.first.last_visited_courses).to(
          eq [Course.last, Course.first]
      )
    end

    context "update date" do
      before do
        Attending.first.update_last_visit
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
          Attending.create(course_id: n, user_id: 1, role_id: 1)
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

  describe '#existing_since' do
    before do
      @user = FactoryGirl.create :user
    end
    context "years" do
      context "many" do
        it "returns correct string" do
          allow(Time).to receive(:now) { Time.new + 1.1 * 4.years }
          expect(@user.existing_since).to eq "4 lat"
        end
      end
      context "one" do
        it "returns correct string" do
          allow(Time).to receive(:now) { Time.new + 1.1 * 1.year }
          expect(@user.existing_since).to eq "1 roku"
        end
      end
    end
    context "months" do
      context "many" do
        it "returns correct string" do
          allow(Time).to receive(:now) { Time.new + 4.1 * 1.month }
          expect(@user.existing_since).to eq "4 miesięcy"
        end
      end
      context "one" do
        it "returns correct string" do
          allow(Time).to receive(:now) { Time.new + 1.1 * 1.month }
          expect(@user.existing_since).to eq "1 miesiąca"
        end
      end
    end
    context "days" do
      context "many" do
        it "returns correct string" do
          allow(Time).to receive(:now) { Time.new +  1.1 * 4.days }
          expect(@user.existing_since).to eq "4 dni"
        end
      end
      context "one" do
        it "returns correct string" do
          allow(Time).to receive(:now) { Time.new + 1.1 * 1.day }
          expect(@user.existing_since).to eq "1 dnia"
        end
      end
    end
    context "hours" do
      context "many" do
        it "returns correct string" do
          allow(Time).to receive(:now) { Time.new + 4.hours }
          expect(@user.existing_since).to eq "4 godzin"
        end
      end
      context "one" do
        it "returns correct string" do
          allow(Time).to receive(:now) { Time.new + 1.hour }
          expect(@user.existing_since).to eq "1 godziny"
        end
      end
    end
  end
end
