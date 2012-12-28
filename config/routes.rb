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
  resources :activities
  get '/activities/type/:type_name' => 'activities#type',as: :type_activities
  #resources :userinfos
end
