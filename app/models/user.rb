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

class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true,
                   length: { maximum: 240 }

  has_many :attendings, dependent: :destroy
  has_many :courses, through: :attendings
  has_many :sent_messages, class_name: "Message",
    foreign_key: :sender_id
  has_many :sendings
  has_many :received_messages, through: :sendings, source: :message
  #has_many :owned_courses, through: :attendings, source: :course

  def last_visited_courses(number = nil)
    return last_visited_courses.limit(number) if number
    courses.joins(:attendings).
      order('"attendings"."last_visit" DESC').uniq
  end

  def existing_since
    diff = Time.now - created_at
    if (l = (diff / 1.year.round(3)).round(2).floor) >= 1
      plural("roku", "lat", "lat", l)
    elsif (l = (diff/1.month.to_f).floor) >= 1
      plural("miesiąca", "miesięcy", "miesięcy", l)
    elsif (l = (diff/1.day).floor) >= 1
      plural("dnia", "dni", "dni", l)
    else
      l = (diff/1.hour).floor
      plural("godziny", "godzin", "godzin", l)
    end
  end

  private

  def plural(one, few, many, count)
    count = count.to_int
    str = "#{count} "
    str << if count == 1
             one.to_str
           elsif (2..4).cover? count
             few.to_str
           else
             many.to_str
           end
  end
end
