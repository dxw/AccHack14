Rails.application.routes.draw do
	root to: "welcome#index"

	resources :welcome
  get '/local_authorities', to: 'data_views#local_authorities'
  get '/homelessnesses', to: 'data_views#homelessnesses'
end
