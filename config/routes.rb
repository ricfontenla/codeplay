Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  devise_for :admins

  namespace :admin do
    resources :instructors
    resources :courses do
      resources :lessons, only: [:new, :create, :show, :edit, :update, :destroy]
    end
  end

  namespace :user do
    resources :courses, only: [:show] do
      resources :lessons, only: [:show]
      post 'enroll', on: :member
      get 'my_enrollments', on: :collection
    end
  end

  resources :courses, only: [:show]

  namespace :api do
    namespace :v1 do
      resources :courses, only: [:index, :show, :create, :update, :destroy], param: :code
    end
  end
end
