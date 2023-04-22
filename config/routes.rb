Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  resources :tasks, only: %i[index new create edit update show destroy]
end
