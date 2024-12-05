Rails.application.routes.draw do  
  resources :profiles
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :posts, only: [:index, :show]
      resources :discussions, only: [:index, :show]
    end
  end

  devise_for :users

  resources :posts do
    resources :comments

    member do
      get "bookmark"
    end
  end

  resources :discussions do
    member do
      get "bookmark"
    end

    resources :comments
  end

  resources :subscriptions, only: [:create]

  namespace :admin do
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
