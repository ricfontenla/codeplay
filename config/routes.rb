Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  
  resources :courses do
    resources :lessons, only: [:new, :create, :show, :edit, :update, :destroy]

    post 'enroll', on: :member
    get 'my_enrollments', on: :collection
  end

  resources :instructors
end
