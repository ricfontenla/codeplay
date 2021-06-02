Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  devise_for :admins

  namespace :admin do
    resources :courses do
      resources :lessons, only: [:new, :create, :show, :edit, :update, :destroy]
    end
  end

  namespace :user do
    resources :courses, only: [:index, :show] do
      resources :lessons, only: [:show]
      post 'enroll', on: :member
      get 'my_enrollments', on: :collection
    end
  end
  
  resources :instructors
end
