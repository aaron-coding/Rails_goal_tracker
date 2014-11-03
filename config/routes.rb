Rails.application.routes.draw do
  resources :users, only: [:new, :create, :index, :show] do
    resources :goals, only: [:new, :edit, :update]
  end
  resources :goals, only: :create
  resource :session, only: [:new, :create, :destroy]
  
  root to: "users#home"
end