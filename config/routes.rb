Rails.application.routes.draw do
  devise_for :users
  root "clients#index"
  get "/directory", to: "directories#index"
  namespace :directory do
    resources :branches do
      resources :services
    end
    resources :discounts do
      member do
        get "find_clients"
        get "add_discount_client/:client_id",to: "discounts#add_discount_client",as: :add_discount_client
      end
    end
    resources :users
  end
  resources :clients do
    resources :paid_services
    resources :foods
    member do
      get "handle_visit"
    end
  end
  get "/cashbox", to: "cash_boxes#show"
  scope '/cashbox' do
    resources :incomes, only: [:show]
    resources :encashments, :consumptions, only: [:show,:new,:create]
    resources :transfers, only: [:show,:new,:create] do
      member do
        put "confirme"
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
