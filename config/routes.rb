Rails.application.routes.draw do

  devise_for :users

  resource :user

  resources :events

  namespace :admin do
    root "events#index"
    resources :events
    resources :users do
      resource :profile, :controller => "user_profiles"
    end
  end

  root "events#index"

end
