Preemptivehack::Application.routes.draw do
  root to: 'dashboard#index'
  resources :hackday_organizations, except: :destroy do
    resources :hackdays, except: [:destroy, :index]
  end
  resources :hackdays, only: :show
  resources :users, only: [:create, :index, :new]
  resources :projects, except: [:destroy, :index]
end
