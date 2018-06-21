Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root to: 'toppages#index'
    
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
    
    get 'signup' => 'users#new'
    #resources = :show, :create, :update, :destroy, :index, :new, :editがまとめてつかえる
    resources :users, only: [:index, :show, :new, :create]
end
