Rails.application.routes.draw do
	root to: "welcome#index"

	resources :welcome
  get '/local_authorities', to: 'data_views#local_authorities'
end
