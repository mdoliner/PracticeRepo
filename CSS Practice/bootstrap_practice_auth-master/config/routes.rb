AuthDemo::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resource :user, only: [:create, :new, :show] do
    resource :counter, only: [:update]
  end

  resource :static_pages do
    member do
      get 'home', 'about', 'contact'
    end
  end
end
