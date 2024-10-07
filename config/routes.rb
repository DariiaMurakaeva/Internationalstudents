Rails.application.routes.draw do  
  resources :discussions do
    resources :comments
  end 
  resources :posts do  
    resources :comments  
  end  
  get "welcome/index"  

  get "up" => "rails/health#show", as: :rails_health_check  
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker  
  get "manifest" => "rails/pwa#manifest"  

  root "home#index" # Используйте HomeController для корневого маршрута  
end
