Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :articles do
  resources :articles do
    resources :comments

    member do
      delete 'images_destroy'
    end

    collection do
      get 'search'
      get 'archive'
    end
  end
  get 'confirm_authority', to: 'authentication#confirm_authority'
  post 'confirm_authority_callback', to: 'authentication#confirm_authority_callback'
  # get 'logout', to: 'authentication#logout'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # root  'articles#index'
end
