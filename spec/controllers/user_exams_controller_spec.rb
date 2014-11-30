require 'rails_helper'

RSpec.describe UserExamsController, :type => :controller do
  before do
    @user = FactoryGirl.create :user, email: "wp@wp.pl"
    sign_in @user
    FactoryGirl.create :course
    FactoryGirl.create :lesson_category
    FactoryGirl.create :exam
    FactoryGirl.create :question
  end

  describe "GET new" do
    it "returns http success" do
      expect do
        get :new, id: 1
      end.to change{UserExam.count}.by 1
      expect(assigns(:exam)).to eq Exam.first
      expect(response).to redirect_to question_user_exam_path
    end
  end

  describe "GET question" do
    before do
      get :new, id: 1
    end
    it "returns http success" do
      get :question
      expect(response).to have_http_status(:success)
    end
  end

  describe 'sample exam' do
    before do
      Question.destroy_all
      FactoryGirl.create(:question,
                         name: "Czy ziemia jest płaska?",
                         value: 2)
      Answer.create(name: "Tak", correct: false, question_id: 2)
      Answer.create(name: "Nie", correct: true, question_id: 2)
      FactoryGirl.create(:question,
                         name: "Jakie programy domyślnie ma Łubuntu?",
                         value: 2, form: 1)
      Answer.create(name: "Firefox", correct: true, question_id: 3)
      Answer.create(name: "Google Chrome", correct: false, question_id: 3)
      Answer.create(name: "LibreOffice Writer", correct: true, question_id: 3)
      Answer.create(name: "Microsoft Office Word", correct: false, question_id: 3)
      FactoryGirl.create(:question,
                         name: "Jakiego koloru jest krew ludzka?", form: 2, value: 2)
      Answer.create(name: "Czerwonego", question_id: 4)
      Answer.create(name: "Czerwony", question_id: 4)
      get :new, id: 1
    end

    context "valid answers" do
      before do
        3.times do
          get :question
          case session[:current_question_id].to_i
          when 2
            post :answer, answer: { id: '2' }
          when 3
            post :answer, answer: { id: %w(3 4) }
          else
            post :answer, answer: { text: 'czerwony' }
          end
        end
      end

      it "makes correct result" do
        @ue = UserExam.first
        res = @ue.result
        @ue.update_result
        expect(@ue.result).to eq res
        expect(res).to eq 4
      end
    end


    context "blank_answers" do
      it "creates user_answers" do
        expect do
          3.times do
            get :question
            case session[:current_question_id].to_i
            when 2
              post :answer, answer: { id: '' }
            when 3
              post :answer, answer: { id: ['']}
            else
              post :answer, answer: { text: '' }
            end
          end
        end.to change{UserAnswer.count}.by(3)
      end
    end

    context "end of time" do
      it "redirects from exam" do
        expect do
          3.times do |n|
            get :question
            UserExam.first.update_attribute(:closed, true) if n == 2
            case session[:current_question_id].to_i
            when 2
              post :answer, answer: { id: '' }
            when 3
              post :answer, answer: { id: ['']}
            else
              post :answer, answer: { text: '' }
            end
          end
        end.to change{UserAnswer.count}.by(2)
        expect(:response).to redirect_to course_path(Course.first)
      end
    end
  end
end
