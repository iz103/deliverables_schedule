DeliverablesSchedule::Application.routes.draw do
  root :to => "homepage#index"
  
  resources :deliveries, :only => [:index] do
    collection do
      put :edit_multiple
      put :complete
      put :update_multiple
    end
  end

  resources :deliverables do
    collection do
      get :list_for_tag
      put :manage
      get :deliveries_index
    end
    resources :deliveries do
      collection do
        put :complete
      end
    end
  end

  resources :statuses do
    collection do
      get :list_for_status
    end
  end

  resources :users
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  resources :user_sessions, :only => :create
  match '/:controller(/:action(/:id))'
end