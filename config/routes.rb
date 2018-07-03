Rails.application.routes.draw do
    # トップページを設定するのにrootメソッドをつかう
    root to: 'toppages#index'
    
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
    
    get 'signup' => 'users#new'
    #resources = :show, :create, :update, :destroy, :index, :new, :editがまとめてつかえる
    resources :users, only: [:index, :show, :new, :create, :destroy] do
      member do
        get :followings
        get :followers
        # get '/users/:id/likes' => 'users#likes'
        get :likes
      end
    end
    
    resources :favorites, only: [:create, :destroy]
    resources :microposts, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]
end
