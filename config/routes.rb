Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show, :whatever]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  get 'frequest/:id', to: 'users#frequest', as: 'friend_req'
  get 'accept/:id', to: 'users#accept', as: 'accept'
  get 'reject/:id', to: 'users#reject', as: 'reject'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


