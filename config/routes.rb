Rails.application.routes.draw do
  get 'notfound/index'
  get 'error/index'
  get 'url/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  resources :shortener, path:'/', only: %i[create show index]
end
