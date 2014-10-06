Preemptivehack::Application.routes.draw do
  root to: 'dashboard#index'

  get 'login' => 'session#new', as: 'login'
  post 'login' => 'session#create', as: 'authenticate'
  delete 'logout' => 'session#destroy', as: 'logout'
  get 'logout' => 'session#destroy'

  resources :hackday_organizations, except: [:destroy, :index] do
    resources :hackdays, except: [:destroy, :index]
    resources :hardwares, only: [:create, :new]
    resources :users, only: [:create, :destroy], controller: 'hackday_organizations/users'
  end
  resources :hackdays, only: :show do
    resources :hardware, only: [:create, :new], controller: 'hackdays/hardware'
    resources :projects, except: [:index, :show]
  end
  resources :hardwares, only: [:index]
  resources :users, only: [:create, :edit, :new, :update]
end
