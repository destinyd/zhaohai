Zhaohai::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users do
    get :relationship, on: :collection
    member do
      post :follow
      post :unfollow
    end
  end
  resources :activities do
    collection do
      get :expired
      get :running
    end
    member do
      post :close
    end
    resources :activity_requests do
      member do
        post :accept
        post :deny
      end
    end
  end
  resources :notifications ,except: [:edit,:update,:new,:create]
  get '/activities/type/:type_name' => 'activities#type',as: :type_activities

  #resources :userinfos
end
