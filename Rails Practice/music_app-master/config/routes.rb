Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :show]

  resources :bands

  resources :bands, only: [:show] do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :edit, :show, :update, :destroy] do
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:create, :edit, :show, :update, :destroy]

  resources :tracks, only: [:show]

  resources :notes, only: [:create, :destroy]
end
