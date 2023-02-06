Rails.application.routes.draw do
  
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :questions do
    collection do
      get :solved
      get :unsolved
    end
    member do
      post :solve
    end
    resources :answers, only: [:create, :destroy] do
    end
  end
  
  resources :users, only: [:index]
  
  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :questions, only: [:index, :destroy]
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    # delete '/logout', to: 'sessions#destroy'
  end
end
