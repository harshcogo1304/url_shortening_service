Rails.application.routes.draw do
  resources :urls, only: [:new, :create, :show]
  # get '/:id', to: 'urls#show'
  # root 'urls#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
