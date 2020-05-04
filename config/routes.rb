Rails.application.routes.draw do
  root 'contacts#index'
  get 'contacts/index', as: 'contacts'
  get 'contacts/new', as: 'new_contact'
  post '/contacts/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
