Rails.application.routes.draw do

  devise_for :users

  resources :events

  resource :user

  namespace :admin do
    root "events#index"
    resources :events
  end

  root "events#index"

  get "/faq" => "pages#faq"

end
