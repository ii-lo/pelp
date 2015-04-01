require 'rails_helper'

feature "Sessions", :type => :feature, js: true do
  it "registers in signs in the user" do
    visit root_path
    expect(page.title).to match(/pelp/i)
    click_link "Zarejestruj"
    fill_in :user_name, with: "Robert Bias"
    fill_in :user_email, with: "robert@robert.com"
    fill_in :user_password, with: "asdf1234"
    fill_in :user_password_confirmation, with: "asdf1234"
    click_button "Zarejestruj się"
    expect(page).to have_content "Zarejestrowano"
    visit '/sign_out'
    #click_link "Wyloguj"
    click_link "Zaloguj"
    fill_in :user_email, with: "robert@robert.com"
    fill_in :user_password, with: "asdf1234"
    click_button "Zaloguj"
    expect(page).to have_content "Robert Bias".upcase
    expect(page).to have_content "zalogowany"
  end
end
