Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :articles do
  resources :articles do
    resources :comments

    collection do
      get 'search'
      get 'archive'
    end
  end
  get 'confirm_authority', to: 'authentication#confirm_authority'
  get 'confirm_authority_callback', to: 'authentication#confirm_authority_callback'
  # root  'articles#index'
end
