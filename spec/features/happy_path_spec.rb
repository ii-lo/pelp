
require 'rails_helper'

feature "Happy path", :type => :feature do
  before do
    @create_proc = proc { click_button "Stwórz" }
  end

  it "it creates user and course" do
    visit root_path
    expect(page.title).to match(/pelp/i)
    click_link "Zarejestruj"
    fill_in :user_name, with: "Robert Bias"
    fill_in :user_email, with: "robert@robert.com"
    fill_in :user_password, with: "asdf1234"
    fill_in :user_password_confirmation, with: "asdf1234"
    expect do
      click_button "Zarejestruj się"
    end.to change(User, :count).by(1)
    expect(page).to have_content "Robert Bias"
    click_link "Kursy"
    expect(page).to have_content "Dodaj kurs"
    click_link "Dodaj kurs"
    fill_in :course_name, with: "Mój kurs"
    fill_in :course_description, with: "To mój kurs"
    expect(&@create_proc).to change(Attending, :count).by(1).and(
      change(Course, :count).by(1)
    )
    expect(page).to have_content "ustawień"
    click_link "Ustawienia"
    fill_in :lesson_category_name, with: "Moja kategoria"
    click_button "Stwórz"
    click_link "Mój kurs", match: :first
    expect(page).to have_content "Moja kategoria"
    click_link "Oflaguj"
    expect(page).to have_content "Zabierz flagę"
    click_link "Nowa lekcja w kategorii"
    expect(page).to have_content "Nowa lekcja"
    fill_in :lesson_name, with: "Lekcja pierwsza"
    fill_in :lesson_content, with: "E = mc^2"
    expect(&@create_proc).to change(Lesson, :count).by(1)
    click_link "Mój kurs", match: :first
    click_link "Nowy zestaw materiałów"
    fill_in :material_category_name, with: "Materiały"
    expect(&@create_proc).to change(MaterialCategory, :count).by(1)
    click_link "Mój kurs", match: :first
    expect(page).to have_content "Materiały"
    click_link "Nowy egzamin"
    expect(page).to have_content "Nowy egzamin"
    fill_in :exam_name, with: "Pierwszy egzamin"
    fill_in :exam_duration, with: 2000
    expect(&@create_proc).to change(Exam, :count).by(1)
    FactoryGirl.create(:question_category)
    FactoryGirl.create(:question,
                       name: "Czy ziemia jest płaska?",
                       value: 2)
    Answer.create(name: "Tak", correct: false, question_id: 1)
    Answer.create(name: "Nie", correct: true, question_id: 1)
    click_link "Mój kurs", match: :first
    click_link "Pierwszy egzamin"
    expect do
      click_link "Rozpocznij"
    end.to change(UserExam, :count).by(1)
    visit root_path
    click_link "Wyloguj się"
    expect(page).to have_content "wylogowany"
  end
end
