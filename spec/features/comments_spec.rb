require 'spec_helper'
require 'rails_helper'

feature "comments" do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:other_user) { FactoryGirl.create(:other_user) }
  given!(:public_goal) { FactoryGirl.create(:public_goal, user_id: user.id) }
  given!(:other_public_goal) {
          FactoryGirl.create(:other_public_goal, user_id: other_user.id) }
  
  before(:each) do
    visit new_session_url
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_on "Sign in"
   end
   

  feature "user comments" do
 
   it "user can comment on other users when logged in" do
     visit user_url(other_user)
     comment = Faker::Hacker.say_something_smart
     fill_in "Comment", with: comment
     click_on("Add Comment")
     
     expect(page).to have_content(comment)
   end
 
   it "user cannot comment on other users unless logged in" do
     visit user_url(other_user)
     expect(page).not_to have_selector("submit", text: "Add Comment")
   end

  end

  feature "goal comments" do
 
   it "user can comment on goals when logged in" do
     visit user_goal_url(other_user, other_public_goal)
     comment = Faker::Hacker.say_something_smart
     fill_in "Comment", with: Faker::Hacker.say_something_smart
     click_on("Add Comment")
     
     expect(page).to have_content(comment)
   end
 
   it "user cannot comment on goals unless logged in" do
     visit user_goal_url(other_user, other_public_goal)
     expect(page).not_to have_selector("submit", text: "Add Comment")
   end

  end
  
end