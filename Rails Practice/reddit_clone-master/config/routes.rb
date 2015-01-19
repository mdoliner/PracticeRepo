Rails.application.routes.draw do
  root to: "subs#index"

  resources :users, only: [:new,:create]
  resources :subs, except: [:destroy]

  resources :posts, except: [:index, :destroy] do
    resources :comments, only: [:new]
    member do
      post 'upvote'
      post 'downvote'
    end
  end

  resources :comments, only: [:create, :show] do
    member do
      post 'upvote'
      post 'downvote'
    end
  end

  resource :session, only: [:new,:create,:destroy]

end
