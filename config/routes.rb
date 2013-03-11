Zhaohai::Application.routes.draw do
  use_doorkeeper
  namespace :api do
    namespace :v1 do
      # another api routes
      get '/me' => "credentials#me"
      get '/dashboard' => "credentials#dashboard"
      post '/reg' => "registrations#create"
      post '/test' => "registrations#test"
      resources :activity_requests,except: [:edit,:update,:new]
      resources :users do
        collection do
          get :relationship
          get :friend
        end
        member do
          post :follow
          post :unfollow
        end
      end
      resources :activities do
        collection do
          get :expired
          get :running
          get :points
        end
        member do
          post :close
          post :quit
          post :invite
          get :info
        end
        resources :activity_requests,except: [:edit,:update] do
          member do
            post :accept
            post :deny
          end
        end
      end
      resources :notifications ,except: [:edit,:update,:new,:create] do
        get :read,on: :collection
        get :status,on: :collection
        member do 
          post :accept
          post :deny
        end
      end
      resources :userinfos, except: [:destroy,:index,:show]
    end
  end


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
      get :points
    end
    member do
      post :close
      post :quit
      post :invite
      get :info
      get :invite_friend
    end
    resources :activity_requests,except: [:edit,:update] do
      member do
        post :accept
        post :deny
      end
    end
  end
  resources :notifications ,except: [:edit,:update,:new,:create] do
    get :read,on: :collection
    member do 
      post :accept
      post :deny
    end
  end
  get '/activities/type/:type_name' => 'activities#type',as: :type_activities

  resources :userinfos, except: [:destroy,:index,:show]
end
