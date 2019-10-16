# frozen_string_literal: true

Rails.application.routes.draw do
  resources :games, only: [:show]

  authenticate :user do
    resources :games, except: [:show]
  end

  devise_for :users

  get 'welcome/index'
  root 'welcome#index'
end
