# frozen_string_literal: true

Rails.application.routes.draw do
  authenticate :user do
    resources :games
  end

  devise_for :users

  get 'welcome/index'
  root 'welcome#index'
end
