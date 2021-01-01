Rails.application.routes.draw do
  root to: 'home#index'
  post 'home/get_annotation'
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
