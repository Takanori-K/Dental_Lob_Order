Rails.application.routes.draw do
  get 'users/new'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get '/auth/:provider/callback',    to: 'users#create',       as: :auth_callback
  get '/auth/failure',               to: 'users#auth_failure', as: :auth_failure

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
