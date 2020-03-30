Rails.application.routes.draw do
  get 'casts/show'

  get 'writers/show'

  get 'directors/show'

  get 'actors/show'

  #home
  root 'static_pages#home'
  get  '/help', to:'static_pages#help'
  get  '/about', to:'static_pages#about'
  #signup
  get  '/send_activation_email', to:'users#enter_activaton_email'
  post '/send_activation_email', to:'users#send_activaton_email'
  get  '/authenticate_authcode', to:'users#enter_authcode'
  post '/authenticate_authcode', to:'users#authenticate_authcode'
  get  '/signup', to:'users#new'
  post '/signup',  to:'users#create'
  get  '/confirm', to:'users#confirm'
  post '/confirm', to:'users#confirm'
  #login
  get  '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete  '/logout', to:'sessions#destroy'
  #users_edit
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
  #movie
  get 'movies/list', to:'movies#list'
  get 'movies/list/now', to:'movies#now'
  get 'movies/list/rental_coming', to:'movies#rental_coming'
  get 'movies/list/rental_now', to:'movies#rental_now'
  #get 'movies/list/recommended', to:'movies#recommended'
  get 'movies/list/year/:year', to:'movies#year' 
  get 'movies/list/genre/:genre', to:'movies#genre' 
  get 'movies/list/production/:production', to:'movies#production' 
  #drama
  get 'dramas/list', to:'dramas#list'
  get 'dramas/list/now', to:'dramas#now'
  get 'dramas/list/rental_coming', to:'dramas#rental_coming'
  get 'dramas/list/rental_now', to:'dramas#rental_now'
  #get 'dramas/list/recommended', to:'dramas#recommended'
  get 'dramas/list/year/:year', to:'dramas#year' 
  get 'dramas/list/genre/:genre', to:'dramas#genre' 
  get 'dramas/list/production/:production', to:'dramas#production' 
  #cast
  get 'casts/drama/:id', to:'casts#show_drama'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :email_resets,        only: [:edit]
  resources :movies,              only: [:show]
  resources :dramas,              only: [:show]
  resources :casts,               only: [:show]
end
