Balance::Application.routes.draw do
  resources :categories

  resources :registers do
    match 'destroy_month/:year/:month' => 'registers#destroy_month', as: :destroy_month, via: :delete, on: :collection
    match 'destroy_year/:year' => 'registers#destroy_year', as: :destroy_year, via: :delete, on: :collection
  end
  
  devise_for :users
  root :to => 'home#index'
end
