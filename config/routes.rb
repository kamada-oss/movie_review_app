Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help', to:'static_pages#help'
  get  '/about', to:'static_pages#about'
  get  '/send_activation_email', to:'users#enter_activaton_email'
  post '/send_activation_email', to:'users#send_activaton_email'
  get  '/authenticate_authcode', to:'users#enter_authcode'
  post '/authenticate_authcode', to:'users#authenticate_authcode'
  get  '/signup', to:'users#new'
  post '/signup',  to:'users#create'
  get  '/confirm', to:'users#confirm'
  post '/confirm', to:'users#confirm'
  get  '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete  '/logout', to:'sessions#destroy'
  get 'users/:id/edit_user_prof', to:'users#edit_prof'
  patch '/users/:id/edit_user_prof', to:'users#update_prof'
  get 'users/:id/edit_user_account', to:'users#edit_account'
  get 'users/:id/edit_user_password', to:'users#edit_password'
  patch 'users/:id/edit_user_password', to:'users#update_password'
  get 'users/:id/withdraw', to:'users#withdraw'
  get 'announce_send_password', to:'password_resets#announce_send_password'
  get 'announce_success_change_password', to:'password_resets#announce_success_change_password'
  get 'email_resets/:id/new', to:'email_resets#new'
  post 'email_resets/:id/create', to:'email_resets#create'
  post '/email_resets/:id/update', to:'email_resets#update'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :email_resets,        only: [:edit]
  
end
