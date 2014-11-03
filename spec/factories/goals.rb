FactoryGirl.define do
  factory :private_goal, class: Goal do
    user_id :user_id
    goal "Become Billionaire"
    top_secret true
  end
  
  factory :public_goal, class: Goal do
    user_id :user_id
    goal "Plant a tree"
    top_secret false
  end
  
  factory :other_private_goal, class: Goal do
    user_id :user_id
    goal "Take over the world"
    top_secret true
  end
  
  factory :other_public_goal, class: Goal do
    user_id :user_id
    goal "Write a book"
    top_secret false
  end
end
