Rails.application.routes.draw do
  root 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :index]
      resources :sessions, only: :create
      resources :movies, only: [] do
        collection do
          get :top_rated  
          get :search
          get :details
        end
      end
      resources :viewing_parties, only: [:index, :create] do
        member do
          patch :add_user
        end
      end
    end
  end
end

     # get 'movies/top_rated', to: 'movie#top_rated'
      # get 'movies/search', to: 'movies#search'