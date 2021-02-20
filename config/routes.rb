Rails.application.routes.draw do
  root 'static_pages#top'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :video_room
    end
    resources :orders
      collection do
        delete :'destroy_all'
      end
  end

  get    '/users/:user_id/orders/:id/pdf',          to: 'orders#pdf',           as: :pdf
  patch  '/users/:user_id/orders/:id/admin_update', to: 'orders#admin_update',  as: :admin_update
  get    'auth/:provider/callback', to: 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
