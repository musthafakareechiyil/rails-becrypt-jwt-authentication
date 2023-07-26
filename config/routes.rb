Rails.application.routes.draw do
  resources :users
  post '/auth/login' , to: 'authentication#login'

  namespace :admin do 
    post '' , to: 'admin_sessions#create'
  end

end
