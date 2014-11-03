require 'spec_helper'
require 'rails_helper'

feature "the signup process" do 
  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign up")
  end
  
  feature "signing up a user" do
  
    it "shows username on the users index after signup" do
      visit new_user_url 
      fill_in "Username", with: "Joe"
      fill_in "Password", with: "Joepassword"
      click_on "Sign up"
      
      expect(page).to have_content "Joe"
    end
  end

end

feature "logging in" do 
  given!(:user) { FactoryGirl.create(:user) }
  it "shows username on the homepage after login" do
     visit new_session_url
     fill_in "Username", with: user.username
     fill_in "Password", with: user.password
     click_on "Sign in"
     
     expect(page).to have_content user.username
  end

end

feature "logging out" do 
  given!(:user) { FactoryGirl.create(:user) }
  it "begins with logged out state and has link to sign in" do
    visit root_url
    click_link('Sign in')
    expect(page).to have_content "Log in"
    expect(page).to have_content "Password"
    expect(page).to have_content "Username"
  end
  
  

  it "doesn't show username on the homepage after logout" do
    visit new_session_url
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_on "Sign in"
    click_on "Sign out"
    visit root_url
    expect(page).not_to have_content user.username
  end



end