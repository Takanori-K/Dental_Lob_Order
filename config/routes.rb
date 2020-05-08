Rails.application.routes.draw do

  root 'static_pages#top'
  
   # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    resources :orders
  end
  
  patch  '/users/:user_id/orders/:id/admin_update', to: 'orders#admin_update',  as: :admin_update
  delete '/users/:user_id/orders/destroy_all', to: 'orders#destroy_all', as: :destroy_index
  get    'auth/:provider/callback', to: 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
