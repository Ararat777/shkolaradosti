Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root "clients#index"
  get "/directory", to: "directories#index"
  put "/change_branch",to: "directory/users#change_branch"
  namespace :directory do
    resources :branches do
      resources :services
    end
    resources :discounts do
      member do
        get "find_clients"
        put "add_discount_client/:client_id",to: "discounts#add_discount_client",as: :add_discount_client
        delete "remove_discount_client/:client_id",to: "discounts#remove_discount_client",as: :remove_discount_client
      end
    end
    resources :single_discounts
    resources :users
    resources :months do
      resources :exceptional_days
    end
  end
  resources :clients do
    member do
      get "handle_visit"
      put "remove_countable_service_balance/:service_id",to: "clients#remove_countable_service_balance",as: :remove_countable_service_balance
    end
    collection do
      get "find_client"
    end
  end
  get "/cashbox", to: "cash_boxes#show"
  scope '/cashbox' do
    resources :paid_services do
      member do
        get "surcharge"
      end
    end
    post "/calculate_required_amount",to: "paid_services#calculate_required_amount"
    resources :incomes, only: [:index,:show,:new,:create,:destroy]
    resources :encashments, :consumptions, only: [:index,:show,:new,:create,:destroy]
    resources :transfers, only: [:index,:show,:new,:create] do
      member do
        put "confirme"
      end
    end
  end
  resources :reports, only: [:index,:new] do
    member do
      get "get_report.pdf",to: "reports#get_report_pdf",as: :get_pdf
    end
  end
  post "/make_report.pdf",to: "reports#make_report",as: :make_report_pdf
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
