# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/profile'
  devise_for :users
  root to: 'home#index'
end
