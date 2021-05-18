Rails.application.routes.draw do
  root 'home#index'
  resources :courses, only: [:index, :show, :new, :create]
  resources :instructors
end
