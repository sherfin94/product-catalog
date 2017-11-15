Rails.application.routes.draw do
  namespace :admin do
    resources :categories, only: %i[index new create destroy]
    resources :products, except: %i[show]
  end

  resources :admin, only: %i[index]

  namespace :products do
    resources :filtered, only: %i[index]
  end

  resources :products, only: %i[index]
end
