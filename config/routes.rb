Preemptivehack::Application.routes.draw do
  root to: 'hackday_organizations#index'
  resources :hackday_organizations
  resources :users, only: [:create, :index, :new]
end
