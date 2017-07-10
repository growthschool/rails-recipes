Rails.application.routes.draw do

  devise_for :users

  resources :events

  namespace :admin do
    root "events#index"
    resources :events
  end

  root "events#index"

  get "/faq" => "pages#faq"
end
