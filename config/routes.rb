Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  post 'login', to: 'login#login'

  devise_for :users
  devise_scope :user do
    resources :restaurants do
      resources :posts
      resources :claims, only: [:index, :edit, :update] # for seller
    end

    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :posts, only: [:index, :show] do
          resources :restaurants, only: [:index] do
            resources :reviews, only: [:index, :create]
          end
          resources :claims, only: [:create, :show, :destroy]
        end

        get 'my_claims', to: 'claims#my_claims'
      end
    end
  end

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
