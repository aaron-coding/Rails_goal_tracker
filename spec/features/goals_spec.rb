require 'spec_helper'
require 'rails_helper'

feature "create goals" do 
 given!(:user) { FactoryGirl.create(:user) }
 before(:each) do
  visit new_session_url
  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_on "Sign in"
 end
 
  it "user can create goals when logged in" do 
    visit new_user_goal_url(user)
    fill_in "Goal", with: "Become a billionaire"
    click_on "Create goal"
    
    expect(page).to have_content "Become a billionaire"
  end
    
  it "user cannot create goals if not logged in" do
    click_on "Sign out"
    visit new_user_goal_url(user)

    expect(page).not_to have_content "Create new goal"
  end
end

feature "filter goals" do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:other_user) { FactoryGirl.create(:other_user) }
  given!(:private_goal) { FactoryGirl.create(:private_goal, user_id: user.id) }
  given!(:public_goal) { FactoryGirl.create(:public_goal, user_id: user.id) }
  given!(:other_private_goal) { FactoryGirl.create(:other_private_goal, user_id: other_user.id) }
  given!(:other_public_goal) { FactoryGirl.create(:other_public_goal, user_id: other_user.id) }
  
  before(:each) do
   visit new_session_url
   fill_in "Username", with: user.username
   fill_in "Password", with: user.password
   click_on "Sign in"
  end
  
  it "user can see his own private goals" do
    visit user_url(user)
    expect(page).to have_content private_goal.goal
  end
  
  it "user can see his own public goals" do
    visit user_url(user)
    expect(page).to have_content public_goal.goal
  end
  
  it "user can see other's public goals" do
    visit user_url(other_user)
    expect(page).to have_content other_public_goal.goal
  end
  
  it "user cannot see other's private goals" do
    visit user_url(other_user)
    expect(page).not_to have_content other_private_goal.goal
  end
  
end