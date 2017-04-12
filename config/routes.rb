Rails.application.routes.draw do

  devise_for :users

  resource :user

  resources :events

  namespace :admin do
    root "events#index"
    resources :events
  end

  root "events#index"

end
