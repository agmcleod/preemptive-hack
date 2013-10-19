Preemptivehack::Application.routes.draw do
  root to: 'dashboard#index'
  resources :hackday_organizations
  resources :users, only: [:create, :index, :new]
end
