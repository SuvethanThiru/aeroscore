# === ROUTES ===
# config/routes.rb
Rails.application.routes.draw do
  root 'home#index'
  
  namespace :api do
    namespace :v1 do
      resources :airlines do
        resources :reviews
      end
    end
  end
  
  get '*path', to: 'home#index', via: :all
end