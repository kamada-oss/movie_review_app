Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help', to:'static_pages#help'
  get  '/about', to:'static_pages#about'
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
  resources :users
end
