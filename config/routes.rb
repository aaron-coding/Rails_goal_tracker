Rails.application.routes.draw do
  resources :users, only: [:new, :create, :index, :show] do
    resources :goals, only: [:new, :edit, :update, :show]
    resources :comments, only: [:create]
  end
  
  resources :goals, only: [:create, :destroy] do
    resources :comments, only: [:create]
  end
  
  resource :session, only: [:new, :create, :destroy]
  
  root to: "users#home"
end