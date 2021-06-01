Rails.application.routes.draw do
  devise_for :admins
  root 'home#index'

  devise_for :users

  namespace :admin do
    resources :courses
  end
  
  resources :courses, only: [:show] do
    resources :lessons, only: [:new, :create, :show, :edit, :update, :destroy]

    post 'enroll', on: :member
    get 'my_enrollments', on: :collection
  end

  resources :instructors
end
