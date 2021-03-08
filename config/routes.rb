Rails.application.routes.draw do

  devise_for :users

  resources :events do
    resources :registrations
  end

  resource :user

  namespace :admin do
    root "events#index"
    resources :events do
      resources :tickets, :controller => "event_tickets"

      member do
        post :reorder
      end

      collection do
        post :bulk_update
      end
    end
    resources :users do
      resource :profile, :controller => "user_profiles"

      member do
        post :reorder
      end
    end
  end

  root "events#index"

  get '/faq' => "pages#faq"

end
