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
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  location               :string
#  company                :string
#  contact_mail           :string
#  home_url               :string
#  note                   :string
#

class User < ActiveRecord::Base
  after_create :check_for_accepted_invitations

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :attendings, dependent: :destroy
  has_many :courses, through: :attendings
  has_many :admin_courses, -> { where attendings: { role: [1, 2] } },
    through: :attendings, source: :course
  has_many :owned_courses, -> { where attendings: { role: 2 } },
    through: :attendings, source: :course
  has_many :user_exams
  has_many :invitations

  validates :name, presence: true,
            length: { maximum: 240 }

  validates :location, length: { maximum: 240 }
  validates :company, length: { maximum: 240 }
  validates :contact_mail, length: { maximum: 240 },
    format: /@/, allow_blank: true
  validates :home_url, length: { maximum: 240 },
    format: /\Ahttp/i, allow_blank: true
  validates :note, length: { maximum: 240 }

  def last_visited_courses(number = nil)
    return last_visited_courses.limit(number) if number
    courses.joins(:attendings)
      .order('"attendings"."last_visit" DESC').uniq
  end

  def existing_since
    diff = Time.diff(Time.now, created_at)
    if (l = diff[:year]) >= 1
      plural("roku", "lat", "lat", l)
    elsif (l = diff[:month]) >= 1
      plural("miesiąca", "miesięcy", "miesięcy", l)
    elsif (l = diff[:week]) >= 1
      plural("tygodnia", "tygodni", "tygodni", l)
    elsif (l = diff[:day]) >= 1
      plural("dnia", "dni", "dni", l)
    else
      l = diff[:hour]
      plural("godziny", "godzin", "godzin", l)
    end
  end

  private

  def plural(one, few, many, count)
    count = count.to_int
    str = "#{count} "
    str << case count
           when 1
             one.to_str
           when 2..4
             few.to_str
           else
             many.to_str
           end
  end

  def check_for_accepted_invitations
    Invitation.where('LOWER("email") = ?', email.downcase).accepted.uniq.each do |i|
      attendings.create(course_id: i.course_id)
    end
  end
end
