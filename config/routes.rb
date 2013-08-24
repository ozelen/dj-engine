DjEngine::Application.routes.draw do

  get "locations/search" => "locations#search"

  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations'
  }
  resources :authentications

  scope "(:locale)", locale: /(en|uk|ru)/ do # /#{I18n.available_locales.join('|')}/ do

    resources :measures
    resources :measure_categories
    resources :values
    resources :posts
    resources :resorts

    post 'values/:id' => 'values#update'

    resources :types

    resources :galleries
    resources :photos
    resources :comments

    resources :hotels do
      resources :rooms do
        resources :prices
      end
      resources :services
      resources :periods
      resources :prices
      resources :galleries
      resources :photos
      resources :posts, only: :show
    end

    resources :streams do
      resources :post, only: :show
    end
    scope '(:stream)', stream: /#{Stream.all.map { |s| s.node.name }.join('|')}/ do
      resources :hotels, only: :index
      resources :resorts, only: :index
      get 'blog' => 'streams#blog', as: :stream_blog
      get 'posts/:post_id' => 'posts#show'
      scope 'blog' do
        get 'tags/:tag' => 'hotels#blog', as: :tag
      end
    end

    scope 'hotels/:hotel_id' do
      get 'pricelist' => 'hotels#pricelist'
      get 'pricelist/edit' => 'hotels#edit_pricelist'
      get 'album' => 'hotels#album'
      get 'albums/edit' => 'hotels#edit_albums'
      get 'reviews' => 'hotels#comments'
      get 'blog' => 'hotels#blog', as: :blog
      scope 'blog' do
        get 'tags/:tag' => 'hotels#blog', as: :tag
      end
      get 'posts/:post_id' => 'posts#show'
      #get 'blog/:post_id' => 'hotels#show_post'
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


    resources :nodes, only: [:index, :new, :create]
    resources :nodes, path: '', except: [:index, :new, :create]

  end
end
