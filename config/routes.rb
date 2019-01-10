Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :articles do
  resources :articles, :path => '/' do
    resources :comments

    collection do
      get 'search'
      get 'archive'
    end
  end
  # root  'articles#index'
end
