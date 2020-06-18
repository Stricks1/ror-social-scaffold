Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show, :whatever]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  get 'whatever/:id', to: 'users#whatever', as: 'whatever'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


