Rails.application.routes.draw do
  resources :places, only: [:show]
  authenticate :user do
    resources :games do
      member do
        get 'edit_react'
        put 'update_react'
      end
    end
    resources :choices
    resources :places, except: [:show]
  end
  devise_for :users
  get 'welcome/index'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
