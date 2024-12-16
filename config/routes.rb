Rails.application.routes.draw do  
  get "bookmarks/toggle"
  resources :profiles
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :posts, only: [:index, :show]
      resources :discussions, only: [:index, :show]
    end
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

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

  resources :application_forms do
    member do
      patch :take_student
    end
  end

  get 'my_students', to: 'application_forms#my_students', as: 'my_students'


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
