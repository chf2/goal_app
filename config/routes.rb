Rails.application.routes.draw do
  resources :users
  resource :session, only: [:create, :destroy, :new]
  resources :goals do
    member do
      post 'toggle'
      post 'cheer'
    end
  end
  resources :comments, only: [:create, :destroy]
end
