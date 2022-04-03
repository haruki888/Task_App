Rails.application.routes.draw do
  get 'tasks/index'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post 'tasks/:id/destroy', to:'tasks#destroy',as: :destroy_task
  
  resources :users do
    resources :tasks 
  end  
end
