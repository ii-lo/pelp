# == Schema Information
#
# Table name: questions
#
#  id                    :integer          not null, primary key
#  exam_id               :integer
#  name                  :text(255)
#  value                 :integer
#  created_at            :datetime
#  updated_at            :datetime
#  form                  :integer          default("0")
#  question_category_id  :integer
#  correct_answers_count :integer          default("0")
#  picture_file_name     :string(255)
#  picture_content_type  :string(255)
#  picture_file_size     :integer
#  picture_updated_at    :datetime
#

class Question < ActiveRecord::Base
  FORMS = [:single, :multiple, :open]
  enum form: FORMS

  before_save :update_exam_max
  after_destroy :update_exam_max


  belongs_to :exam
  belongs_to :question_category

  has_many :answers, dependent: :delete_all
  has_many :correct_answers, -> { correct }, class_name: 'Answer'
  has_many :wrong_answers, -> { wrong }, class_name: 'Answer'
  has_many :user_answers, dependent: :destroy

  validates :exam_id, presence: true
  validates :name, presence: true
  validates :value, presence: true,
            inclusion: 0..200
  validates :question_category_id, presence: true
  validates :form, presence: true

  has_attached_file :picture, styles: {
    medium: "300x300>",
    thumb: "100x100>",
    large: "800x800"
  }, default_url: ''
  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\Z/,
    size: { in: 0..5.megabytes }
  attr_accessor :delete_picture
  before_validation { picture.clear if delete_picture == '1' }

  def string_form
    case form
    when 'single'
      "Pojedynczego wyboru"
    when 'multiple'
      "Wielokrotnego wyboru"
    else
      "Otwarte"
    end
  end

  private

  def update_exam_max
    exam.update_max_points
  end
end
