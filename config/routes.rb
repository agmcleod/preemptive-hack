Preemptivehack::Application.routes.draw do
  root to: 'dashboard#index'
  resources :hackday_organizations, except: :destroy do
    resources :hackdays, except: [:destroy, :index]
    resources :hardwares, only: [:create, :new]
    resources :users, only: [:create, :destroy], controller: 'hackday_organizations/users'
  end
  resources :hackdays, only: :show do
    resources :hardware, only: [:create, :new], controller: 'hackdays/hardware'
    resources :projects, except: [:index, :show]
  end
  resources :users, only: [:create, :index, :new]
end
