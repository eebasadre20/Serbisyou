Rails.application.routes.draw do
  resources :authenticates
  resources :authsessions

  #post '/rate' => 'rater#create', :as => 'rate'
  devise_for :clients, path_names: { sign_in: 'login', sign_out: 'logout' }

  resources :comments do
    collection { post 'all' }
  end
  resources :ratings, only: :update
  
  resources :clients do
    resources :comments, :only => [:create, :destroy]
  end

  resources :users, shallow: true do
    resources :comments

    resources :serviceproviders do
     
    end

    collection do
        get 'login'
     delete 'logout'
        get 'get_barangay'
        get 'get_serviceprovider'
        get 'get_servicelist'
        get 'get_session_user'
        get 'get_categories'
        get 'get_clearances'
        get 'get_preview'
        get 'filter_query'
    end

    member do
      get 'get_barangay'
      get 'home'
      post :vote
    end
  end

  resources :clearances, only: :create

  resources :serviceproviders do
    resources :comments, :only => [:create, :destroy]

    collection do
        get 'login'
     delete 'logout'
       post 'new_serviceprovider'
    end

  end

  resources :brgyadmins, except: :show, shallow: true do
    resources :authenticates, only: [:new,:create]
    resources :serviceproviders, only: [:new, :create, :show] do
      resources :clearances, only: :new
    end
    collection do
          get 'login'
       delete 'logout'
          get 'new_serviceprovider'
          get 'serviceproviders_list'
    end
  end
  
  get 'brgyadmins/show_serviceprovider/:id' => 'brgyadmins#show_serviceprovider', as: :show_serviceprovider
  get 'brgyadmins/serviceprovider_info/:id' => 'brgyadmins#serviceprovider_info', as: :serviceprovider_info
  get 'serviceproviders/:id/preview' => 'users#preview', as: :serviceprovider_preview

  root to: 'users#index'
  match ':controller(/:action(/:id(.:format)))', :via => [:get, :post]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
