Rails.application.routes.draw do
  resources :stampeds
  resources :permissions
  resources :sales_invoices
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # defaults to dashboard
  #root :to => redirect('/singleview')

  # view routes
  #get '/singleview' => 'singleview#index'

  # api routes
  get '/api/i18n/:locale' => 'api#i18n'

  devise_for :users
  root :to => redirect('/welcome')
  get '/welcome' => 'welcome#index'

  get 'check_stock_quantity', to: 'forms#check_stock_quantity'

  resources :movement_proofs
  resources :movement_types
  resources :product_categories
  resources :brands
  resources :deposits
  resources :product_items
  resources :order_tickets
  resources :forms do
    collection do
      get :new_request_proof
      get :request_forms_index
    end
  end
  resources :orders do
    collection do
      get :new_component_proof
      get :component_orders_index
    end
  end
  resources :products do
    collection do
      get :new_component
    end
  end

  resources :movement_proof_details
  resources :stocks
  resources :roles do
    member do
      get :user
    end
  end


resources :cash_movements do
  collection do
    put :pay_invoices
  end
end

  #client routes
  #get '/clients/new', to: 'clients#new', as: 'new_client'
  resources :clients

  #providers routes
  #resources :employees

  #employees routes
  #resources :providers

  resources :users, only: [:index]

  resources :people do
    collection do
      get :clients
      get :new_client
    end
  end

end
