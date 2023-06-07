Rails.application.routes.draw do
  resources :urls, only: [:new, :create]

  get '/urls/get_url', to: 'urls#redirect_to_long_url'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
