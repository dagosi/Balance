Balance::Application.routes.draw do
  resources :registers
  devise_for :users
  root :to => 'home#index'
end
