Rails.application.routes.draw do
  namespace :admin do
    resources :categories, only: %i[index new create destroy]
  end

  get 'admin/index'

  namespace :products do
    get 'filtered/index/:categories', to: 'filtered#index'
  end

  get 'products/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
