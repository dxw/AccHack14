Rails.application.routes.draw do
	root to: "welcome#index"

  resources :local_authorities, only: [:index, :show]

	get '/about', to: 'welcome#about'
  get '/local_authorities', to: 'data_views#local_authorities'
  get '/homelessnesses', to: 'data_views#homelessnesses'
  get '/social_housing_sales', to: 'data_views#social_housing_sales'
  get '/social_housing', to: 'data_views#social_housing'
end
