Rails.application.routes.draw do


  devise_for :users
  resource :user
  resources :events

  namespace :admin do
    root "events#index"
    resources :events do
      resources :tickets, :controller => "event_tickets"

      collection do
        post :bulk_update
      end
    end
    
    resources :users do
      resource :profile, :controller => "user_profiles"
    end
  end

  get "/faq" => "pages#faq"

  root "events#index"

end
