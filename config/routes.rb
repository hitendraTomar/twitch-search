# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/search', to: 'twitchers#search'
  # get '/feeling_lucky', to: 'twitch_content#feeling_lucky'
  post '/results', to: 'twitchers#results'
  get '/history', to: 'users#history'
  post '/add_to_history', to: 'users#add_to_history'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
