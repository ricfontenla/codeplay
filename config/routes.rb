Rails.application.routes.draw do
  root 'home#index'
  
  resources :courses do
    resources :lessons, only: [:new, :create, :show, :edit, :update, :destroy]
  end

  resources :instructors
end
