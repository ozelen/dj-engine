DjEngine::Application.routes.draw do

  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations'
  }

  resources :authentications

    namespace :mercury do
      resources :images
    end

  mount Mercury::Engine => '/'

  scope "(:locale)", locale: /(en|uk|ru)/ do # /#{I18n.available_locales.join('|')}/ do



    resources :assignments
    resources :tag_options
    resources :measures
    resources :measure_categories
    resources :values
    post 'values/:id' => 'values#update'

    resources :types

    resources :hotels do
      member { post :mercury_update }
      resources :rooms do
        resources :prices
      end
      resources :services
      resources :periods
      resources :prices
    end
    scope 'hotels/:hotel_id' do
      get 'pricelist' => 'hotels#pricelist'
      get 'pricelist/edit' => 'hotels#edit_pricelist'
    end

    scope "(:whose)", scope: /(my|our)/ do
      resources :hotels
    end

    resources :regions
    resources :cities

    get 'home', :to => 'nodes#home'

    resources :user_sessions
    match 'login'  => "user_sessions#new",      as: :login
    match 'logout' => "user_sessions#destroy",  as: :logout

    resources :users
    resource :user, :as => 'account'  # a convenience route
    match 'register' => 'users#new', :as => :signup
    #match 'account' => 'users#edit', :as => :account

    root :to => 'nodes#home'


    #get '/:name', to: 'nodes#page'
    #put '/:page_name', to: 'nodes#mercury_update' do
    #  member { post :mercury_update }
    #end

    resources :nodes, only: [:index, :new, :create]
    resources :nodes, path: '', except: [:index, :new, :create]

  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
