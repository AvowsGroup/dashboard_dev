Rails.application.routes.draw do
  get 'third_dashboard/index'
  get 'second_dashboard/index_test'
  get 'third_dashboard/third_db_data'
  get 'second_dashboard/index'
  get 'first_dashboard/index'
  get 'home/index'
  get 'second_dashboard/towns'
  get 'second_dashboard/filter'
  get 'customer_satisfaction/index'
  get 'customer_satisfaction/filterapply'
  get 'service_provider/index'
  get 'districts/:districtname' => 'second_dashboard#statevalues'
  get 'districtname/:districtvalue' => 'second_dashboard#districtvalues'
  post 'refresh_dashboards' => 'refresh_dashboards#create'
  get 'refresh_dashboards' => 'refresh_dashboards#get_interval'
  resources :first_dashboard ,only: [:index] do 
    collection do
      match 'excel_generate', to: 'first_dashboard#excel_generate', via: [:get, :post], defaults: { format: :xlsx }

      # post '/excel_generate',to: "first_dashboard#excel_generate" , defaults: { format: :xlsx } 
    end 
  end
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
