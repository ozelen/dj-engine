class SlugConstraint
  def initialize type
    @type = type
  end

  def matches? request
    node = Node.find_by_name request[@type.parameterize]
    node && node.accessible_type == @type ? true : false
  end
end

DjEngine::Application.routes.draw do
  # users and authentications
  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations'
  }
  resources :authentications

  scope "(:locale)", locale: /(en|uk|ru)/ do # /#{I18n.available_locales.join('|')}/ do
    # homepage
    root :to => 'nodes#home'
    get 'home', :to => 'nodes#home'

    # admin settings: types and measures
    resources :measures
    resources :measure_categories
    resources :values
    resources :types
    post 'values/:id' => 'values#update'

    # editor's interaction
    resources :posts
    resources :galleries
    resources :photos
    resources :comments

    # location and addresses
    get "locations/search" => "locations#search"
    resources :regions
    resources :cities

    # user sessions
    resources :user_sessions
    match 'login'  => "user_sessions#new",      as: :login
    match 'logout' => "user_sessions#destroy",  as: :logout

    # user's preferences
    resources :users
    resource :user, :as => 'account'  # a convenience route
    match 'register' => 'users#new', :as => :signup
    match 'account' => 'users#edit', :as => :account

    # hotels
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

    match ':hotel_id/rooms' => 'rooms#index', as: :hotel_rooms
    match ':hotel_id/rooms/:id' => 'rooms#show', as: :hotel_room
    match ':hotel_id/services' => 'services#index', as: :hotel_services
    match ':hotel_id/services/:id' => 'services#show', as: :hotel_service
    match ':hotel_id/pricelist' => 'hotels#pricelist', as: :hotel_pricelist
    match ':hotel_id/pricelist/edit' => 'hotels#edit_pricelist', as: :edit_hotel_pricelist
    match ':hotel_id/album' => 'hotels#album', as: :hotel_album
    match ':hotel_id/albums/edit' => 'hotels#edit_albums', as: :edit_hotel_albums
    match ':hotel_id/comments' => 'hotels#comments', as: :hotel_comments
    match ':hotel_id/blog' => 'hotels#blog', as: :hotel_blog, constraints: SlugConstraint.new('Hotel')
    match ':hotel_id/blog/tags/:tag' => 'hotels#blog', as: :tag, constraints: SlugConstraint.new('Hotel')
    match ':hotel_id/contacts' => 'hotels#contacts', as: :hotel_contacts

    scope 'hotels/:hotel_id' do
      get 'pricelist' => 'hotels#pricelist'
      get 'pricelist/edit' => 'hotels#edit_pricelist'
      get 'album' => 'hotels#album'
      get 'albums/edit' => 'hotels#edit_albums'
      get 'reviews' => 'hotels#comments'
      get 'blog' => 'hotels#blog', as: :blog

      get 'posts/:post_id' => 'posts#show'
      #get 'blog/:post_id' => 'hotels#show_post'
    end

    # streams
    get ':stream' => 'streams#show', constraints: SlugConstraint.new('Stream')
    resources :streams do
      resources :post, only: :show
    end

    scope ':stream', constraints: SlugConstraint.new('Stream') do
      resources :hotels, only: :index
      get ':resorts' => 'resorts#index', as: :stream_resorts
      get 'blog' => 'streams#blog', as: :stream_blog
      get 'posts/:post_id' => 'posts#show'
      scope 'blog' do
        get 'tags/:tag' => 'streams#blog', as: :tag
      end
    end

    # resorts
    resources :resorts
    get 'resorts' => 'resorts#index', as: :resorts
    match ':resort_id/hotels' => 'hotels#index', as: :resort_hotels, constraints: SlugConstraint.new('Resort')

    resources :nodes, only: [:index, :new, :create]
    resources :nodes, path: '', except: [:index, :new, :create]

  end
end

