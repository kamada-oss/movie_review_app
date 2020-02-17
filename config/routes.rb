Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help', to:'static_pages#help'
  get  '/about', to:'static_pages#about'
  get  '/enter_activaton_email', to:'users#enter_activaton_email'
  post '/send_activation_email', to:'users#send_activaton_email'
  post '/enter_activation_code', to:'users#enter_activation_code'
  get  '/signup', to:'users#new'
  post '/signup',  to:'users#create'
  post '/confirm', to:'users#confirm'
  get  '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete  '/logout', to:'sessions#destroy'
  get 'users/:id/edit_user_prof', to:'users#edit_prof'
  patch '/users/:id/edit_user_prof', to:'users#update_prof'
  get 'users/:id/edit_user_account', to:'users#edit_account'
  get 'users/:id/edit_user_email', to:'users#edit_email'
  get 'users/:id/edit_user_password', to:'users#edit_password'
  patch 'users/:id/edit_user_password', to:'users#update_password'
  get 'users/:id/withdraw', to:'users#withdraw'
  resources :users
  resources :account_activations, only: [:edit]
end
