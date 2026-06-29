Rails.application.routes.draw do
  resources :knockout_results
  resources :teams
  resources :rounds
  resources :sessions
  resources :channels
  resources :fixtures
  resources :results
  resources :standings
  resources :criteria
  
  post 'standings/recalculate', to: 'standings#recalculate', as: 'recalculate_standings'
  post 'standings/init', to: 'standings#init', as: 'init_standings'
  get '/list_fixtures', to: 'fixtures#list_fixtures'
  
  root 'teams#index'
end