Rails.application.routes.draw do

  devise_for :users

  resources :events do
    resources :registrations do
      member do
        get "steps/1" => "registrations#step1", :as => :step1
        patch "steps/1/update" => "registrations#step1_update", :as => :update_step1
        get "steps/2" => "registrations#step2", :as => :step2
        patch "steps/2/update" => "registrations#step2_update", :as => :update_step2
        get "steps/3" => "registrations#step3", :as => :step3
        patch "steps/3/update" => "registrations#step3_update", :as => :update_step3
      end
    end
  end

  resource :user


  namespace :admin do
    root "events#index"

    resources :versions do
      post :undo
    end

    resources :events do
      resources :registrations, :controller => "event_registrations" do
        collection do
          post :import
        end
      end

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
