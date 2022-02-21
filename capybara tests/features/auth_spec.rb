require 'rails_helper'

feature "the signup process" do
  
  scenario "has new user page" do
    visit new_user_url
    expect(page).to have_content "Sign up"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email', :with => "testing@email.com"
      fill_in 'Password', :with => "biscuits"
      click_on 'sign up'
    end

    scenario "redirects to bands index page after signup" do
      expect(page).to have_content "Bands"
    end
  end

  feature "with an invalid user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email', :with => "testing@email.com"
      click_on "sign up"
    end

    scenario "re-renders the sign up page after failed signup" do
      expect(page).to have_content "Sign up"
    end
  end
end