# frozen_string_literal: true

Rails.application.routes.draw do
  authenticate :user do
    resources :games, except: %i[show index]
  end

  resources :games, only: %i[show index]

  devise_for :users

  get 'welcome/index'
  root 'welcome#index'
end
