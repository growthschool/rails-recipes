Rails.application.routes.draw do

  devise_for :users
  resources :events

  resource :user
  namespace :admin do
    root "events#index"

    resources :versions do
      post :undo
    end

    resources :events do
      resources :registration, :controller => "event_registrations"
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
     end
  end



  root "events#index"

  get "/faq" => "pages#faq"
end
