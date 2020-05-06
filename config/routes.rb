Rails.application.routes.draw do
  devise_for :users
  root 'contacts#index'
  resources :contacts, except: [:show] do 
      get 'autocomplete', on: :collection
  end
  post '/groups', to: 'groups#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
