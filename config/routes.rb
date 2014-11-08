Rails.application.routes.draw do
	root to: "welcome#index"

	get '/about', to: 'welcome#about'
  get '/local_authorities', to: 'data_views#local_authorities'
end
