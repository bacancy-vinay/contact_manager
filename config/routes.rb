Rails.application.routes.draw do
  get 'dashboard/index'
  get 'home/index'
  root 'home#index'
  resources :contacts, except: [:show] do 
      get 'autocomplete', on: :collection
  end
  devise_for :users, path: 'auth', controllers: { registrations: :user_registrations}, path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register'}

  post '/groups', to: 'groups#create'
  get '/dashboard', to: 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
