
require 'rails_helper'

feature "Happy path", :type => :feature, js: true do
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
    click_button "Zarejestruj się"
    expect(page).to have_content "Robert Bias".upcase
    click_link "Kursy"
    expect(page).to have_content "Dodaj kurs"
    click_link "Dodaj kurs"
    fill_in :course_name, with: "Mój kurs"
    fill_in :course_description, with: "To mój kurs"
    click_button "Stwórz"
    expect(page).to have_content "ustawień"
    click_link "Ustawienia"
    fill_in :lesson_category_name, with: "Moja kategoria"
    click_button "Stwórz"
    click_link "Mój kurs", match: :first
    expect(page).to have_content "Moja kategoria"
    click_link "Nowa lekcja w kategorii"
    expect(page).to have_content "Nowa lekcja"
    fill_in :lesson_name, with: "Lekcja pierwsza"
    fill_in :lesson_content, with: "E = mc^2"
    click_button "Stwórz"
    click_link "Mój kurs", match: :first
    click_link "Nowy zestaw materiałów"
    fill_in :material_category_name, with: "Materiały"
    click_button "Stwórz"
    click_link "Mój kurs", match: :first
    expect(page).to have_content "Materiały"
    click_link "Nowy egzamin"
    expect(page).to have_content "Nowy egzamin"
    fill_in :exam_name, with: "Pierwszy egzamin"
    fill_in :exam_duration, with: 2000
    click_button "Stwórz"
    fill_in :question_category_name, with: "Nowa kategoria"
    click_button "Stwórz"
    click_link "Rozwiń"
    click_link "Nowe pytanie"
    fill_in :question_name, with: "Czy ziema jest płaska?"
    fill_in :question_value, with: "2"
    first(:button, "Stwórz").click
    click_link "Pokaż odpowiedzi"
    fill_in :answer_name, with: "Tak"
    page.execute_script(%{$('[name="answer[correct]"]').val(1)})
    page.find('#new_answer').find(".btn-default").click
    fill_in :answer_name, with: "Nie"
    page.find('#new_answer').find(".btn-default").click
    click_link "Mój kurs", match: :first
    click_link "Pierwszy egzamin"
    click_link "Rozpocznij"
    choose("Tak")
    click_button "Odpowiedz"
    expect(page).to have_content "100%"
    visit root_path
    click_link "Wyloguj się"
    expect(page).to have_content "wylogowany"
  end
end
