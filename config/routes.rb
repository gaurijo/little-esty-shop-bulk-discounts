Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  resources :admin, only:[:index]
  
  namespace :admin do
    resources :invoices, only: [:index, :show]
    resources :merchants, only: [:index, :show]
    get '', to: 'dashboard#index', as: '/'
  end

  get '/merchants', to: 'merchants#index'

  get '/merchants/:merchant_id/discounts/new', to: 'discounts#new'
  get '/merchants/:merchant_id/discounts/:id', to: 'discounts#show'
  get '/merchants/:merchant_id/discounts', to: 'discounts#index'
  post '/merchants/:merchant_id/discounts', to: 'discounts#create'
  delete '/merchants/:merchant_id/discounts/:id', to: 'discounts#destroy'

  get '/merchants/:merchant_id/dashboard', to: 'dashboard#index'
  
  get '/merchants/:id', to: 'merchants#show'
  get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  get '/merchants/:merchant_id/items/:id/edit', to: 'items#edit'
  patch '/merchants/:merchant_id/items/:id', to: 'items#update'
  get '/merchants/:merchant_id/items/:id', to: 'items#show'
  get '/merchants/:id/invoices', to: 'merchants#show'
  get '/merchants/:id/invoices/:id', to: 'merchant_invoices#show'

  get '/admin/merchants', to: 'merchants#admin_index'
  get '/admin/merchants/:id', to: 'merchants#admin_show'
  get '/admin/merchants/:id/edit', to: 'merchants#edit'
  patch '/admin/merchants/:id', to: 'merchants#update'
end
