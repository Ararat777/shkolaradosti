Rails.application.routes.draw do
  devise_for :users
  root "clients#index"
  resources :clients do
    resources :paid_services
  end
  resources :transfers
  
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
