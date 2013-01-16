Zhaohai::Application.routes.draw do
  use_doorkeeper
  namespace :api do
    namespace :v1 do
      # another api routes
      get '/me' => "credentials#me"
      get '/dashboard' => "credentials#dashboard"
      post '/reg' => "registrations#create"
      resources :activities,except: [:edit,:update,:new]
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
  end
  get '/activities/type/:type_name' => 'activities#type',as: :type_activities

  resources :userinfos, except: [:destroy,:index,:show]
end
