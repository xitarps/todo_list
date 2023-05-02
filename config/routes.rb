Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :tasks, only: %i[index create update show destroy]
    end
  end

  resources :tasks, only: %i[index new create edit update show destroy] do
    collection do
      get 'search'
    end
  end
end
