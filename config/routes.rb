Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :customers, only: %i[show] do
        resources :subscriptions, only: %i[index show update create]
      end
    end
  end
end
