Rails.application.routes.draw do
  root 'static_pages#top'
  get 'error_top', to: "static_pages#error_top"

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  post   '/guest_login', to: 'sessions#new_guest'
  post   '/admin_guest_login', to: 'sessions#new_admin_guest'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :video_room
    end
    resources :orders
      collection do
        delete :destroy_all
      end
  end

  get    '/users/:user_id/orders/:id/pdf',          to: 'orders#pdf',           as: :pdf
  patch  '/users/:user_id/orders/:id/admin_update', to: 'orders#admin_update',  as: :admin_update
  get    'auth/:provider/callback', to: 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
