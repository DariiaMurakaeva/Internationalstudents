Rails.application.routes.draw do  
  devise_for :users

  resources :posts do
    resources :comments
  end

  resources :discussions do
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
