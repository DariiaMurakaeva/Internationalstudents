Rails.application.routes.draw do  
  get "bookmarks/toggle"
  resources :profiles
  
  namespace :api, format: 'json' do
    namespace :v1 do
      post 'register', to: 'registrations#create'
      resources :posts, only: [:index, :show, :create]
      resources :profiles, only: [:index, :show, :update, :create]
      resources :discussions, only: [:index, :show, :create]
      resources :application_forms, only: [:index, :create]

      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        post "sign_out", to: "sessions#destroy"
      end
    end
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :profiles do
    member do
      get :content
    end
  end

  resources :posts do
    resources :comments

    member do
      post :bookmark    
      delete :unbookmark
    end
  end

  resources :discussions do
    member do
      post :bookmark
      delete :unbookmark
    end

    resources :comments
  end

  resources :application_forms do
    member do
      patch :take_student
    end
  end

  resources :subscriptions, only: [:create]

  namespace :admin do
    resources :users
    resources :discussions, except: [:index, :show] do
      resources :comments
    end 
  
    resources :posts, except: [:index, :show] do  
      resources :comments
    end
    resources :subscriptions  
    
  end

  get "up" => "rails/health#show", as: :rails_health_check  
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker  
  get "manifest" => "rails/pwa#manifest"  

  get "home/index"
  get "home/about" 

  
  root "home#index" # Используйте HomeController для корневого маршрута  
end
