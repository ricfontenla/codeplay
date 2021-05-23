Rails.application.routes.draw do
  root 'home#index'
  resources :courses do
    resources :lessons, only: [:new, :create, :edit, :update]
  end
  resources :instructors
end
