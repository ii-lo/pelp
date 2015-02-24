require 'rails_helper'

RSpec.describe UserExamsController, :type => :controller do
  before do
    @user = FactoryGirl.create :user, email: "wp@wp.pl"
    sign_in @user
    FactoryGirl.create :course
    FactoryGirl.create :lesson_category
    FactoryGirl.create :exam
    FactoryGirl.create :question_category
    FactoryGirl.create :question
    QuestionCategory.create(name: 'a', exam_id: 1)
    FactoryGirl.create :attending
  end

  describe "GET new" do
    it "returns http success" do
      get :new, id: 1
      expect(response).to have_http_status 200
    end
  end

  describe "GET start" do
    it "creates new user exam" do
      expect do
        get :start, id: 1
      end.to change{UserExam.count}.by 1
      expect(assigns(:exam)).to eq Exam.first
      expect(response).to redirect_to question_user_exam_path
    end
  end

  describe "GET question" do
    before do
      get :start, id: 1
    end

    it "returns http success" do
      get :question
      expect(response).to have_http_status(:success)
    end

    context "exam closed" do
      it "ends exam" do
        Exam.first.update_attribute(:duration, 1)
        allow(Time).to receive(:now) { Time.new + 5.minutes }
        get :question
        expect(UserExam.first.open?).to eq false
        expect(response).to redirect_to user_exam_path(1)
      end
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
      get :start, id: 1
    end

    context "valid answers" do
      before do
        3.times do
          get :question
          case session[:current_question_id].to_i
          when 2
            post :answer, answer: { id: '2' }
          when 3
            post :answer, answer: { id: ['3', '', '', ''] }
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
        expect(res).to eq 5
      end

      it "renders show page" do
        get :show, id: 1
        expect(response).to be_ok
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
        expect(:response).to redirect_to user_exam_path(1)
      end
    end
  end

  describe "GET exit" do
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
      get :start, id: 1
      2.times do
        get :question
        case session[:current_question_id].to_i
        when 2
          post :answer, answer: { id: '2' }
        when 3
          post :answer, answer: { id: ['3', '', '', ''] }
        else
          post :answer, answer: { text: 'czerwony' }
        end
      end
      get :exit, id: 1
    end

    it "ends exam" do
      expect(UserExam.first.closed).to eq true
      expect(UserExam.first.result).to be > 1
    end
  end

  describe 'GET edit' do
    before do
      FactoryGirl.create :user_exam
      UserExam.first.close!
      Attending.first.update_attribute(:role, 1)
    end

    it 'renders page' do
      get :edit, id: 1
      expect(response).to have_http_status :success
    end
  end

  describe 'GET correct_answer' do
    before do
      Attending.first.update_attribute(:role, 1)
      FactoryGirl.create :question, form: 2
      Answer.create(name: "Czerw", question_id: 2)
      FactoryGirl.create :user_exam
      UserAnswer.create(question_id: 2, text: "Foo", user_exam_id: 1)
      UserExam.first.close!
    end

    it 'makes user answer correct' do
      expect(UserAnswer.first.correct).to be false
      expect(UserExam.first.result).to eq 0
      get :correct_answer, id: 1, user_answer_id: 1
      expect(UserAnswer.first.correct).to be true
      expect(UserExam.first.result).not_to eq 0
      expect(response).to redirect_to edit_user_exam_path(1)
    end
  end
end
