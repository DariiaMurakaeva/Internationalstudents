Rails.application.routes.draw do  
  devise_for :users

  resources :discussions do
    resources :comments
  end 

  resources :posts do  
    resources :comments  
  end  

  get "up" => "rails/health#show", as: :rails_health_check  
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker  
  get "manifest" => "rails/pwa#manifest"  

  get "home/index"
  get "home/about" 

  
  root "home#index" # Используйте HomeController для корневого маршрута  
end
