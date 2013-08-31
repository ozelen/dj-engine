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
    # Homepage
    root :to => 'nodes#home'
    get 'home', :to => 'nodes#home'

    # Admin settings: types and measures
    resources :measures
    resources :measure_categories
    resources :values
    resources :types
    post 'values/:id' => 'values#update'

    # Editor's interaction
    resources :posts
    resources :galleries
    resources :photos
    resources :comments

    # Location and addresses
    get "locations/search" => "locations#search"
    resources :regions
    resources :cities

    # User sessions
    resources :user_sessions
    match 'login'  => "user_sessions#new",      as: :login
    match 'logout' => "user_sessions#destroy",  as: :logout

    # User's preferences
    resources :users
    resource :user, :as => 'account'  # a convenience route
    match 'register' => 'users#new', :as => :signup
    match 'account' => 'users#edit', :as => :account

    # Hotels
    # hotel controls
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

    # shortcut to hotel by slug
    get ':hotel_id'                    => 'hotels#show', constraints: SlugConstraint.new('Hotel'), as: :hotel
    scope ':hotel', constraints: SlugConstraint.new('Hotel') do
      match 'rooms'            => 'rooms#index',               as: :slug_hotel_rooms
      match 'rooms/:id'        => 'rooms#show',                as: :slug_hotel_room
      match 'services'         => 'services#index',            as: :slug_hotel_services
      match 'services/:id'     => 'services#show',             as: :slug_hotel_service
      match 'pricelist'        => 'hotels#pricelist',          as: :slug_hotel_pricelist
      match 'pricelist/edit'   => 'hotels#edit_pricelist',     as: :slug_edit_hotel_pricelist
      match 'album(/:photo_id)'=> 'hotels#album',              as: :album
      match 'albums/edit'      => 'hotels#edit_albums',        as: :slug_edit_hotel_albums
      match 'comments'         => 'hotels#comments',           as: :slug_hotel_comments
      match 'blog'             => 'hotels#blog',               as: :slug_hotel_blog
      match 'posts/:post_id'   => 'posts#show',                as: :hotel_post
      match 'blog/tags/:tag'   => 'hotels#blog',               as: :tag
      match 'contacts'         => 'hotels#contacts',           as: :slug_hotel_contacts
    end

    scope 'hotels/:hotel_id' do
      get 'pricelist/edit' => 'hotels#edit_pricelist'
      get 'albums/edit' => 'hotels#edit_albums'
      get 'posts/:post_id' => 'posts#show'
      get 'blog/:post_id' => 'hotels#show_post'
    end

    # Streams
    resources :streams do
      resources :post, only: :show
    end

    get ':stream' => 'streams#show', constraints: SlugConstraint.new('Stream')

    scope ':stream', constraints: SlugConstraint.new('Stream') do
      resources :hotels, only: :index
      get 'resorts'         => 'resorts#index', as: :stream_resorts
      get 'posts/:post_id'  => 'posts#show'
      get 'blog'            => 'streams#blog', as: :stream_blog
      get 'blog/tags/:tag'  => 'streams#blog', as: :tag
    end

    # Resorts
    resources :resorts
    get 'resorts' => 'resorts#index', as: :resorts
    match ':resort'               => 'resorts#show',      as: :resort,          constraints: SlugConstraint.new('Resort')

    scope ':resort', constraints: SlugConstraint.new('Resort') do
      match 'hotels'        => 'resorts#hotels',    as: :resort_hotels
      match 'blog'          => 'resorts#blog',      as: :resort_blog
      match 'posts/:post_id'=> 'posts#show',        as: :resort_post
      match 'album'         => 'resorts#album',     as: :resort_album
      match 'comments'      => 'resorts#comments',  as: :resort_comments
    end

    resources :tours
    scope 'tours/:tour_id' do
      match 'album(/:photo_id)' => 'tours#album',     as: :album
      match 'comments'          => 'tours#comments',  as: :tour_comments
      match 'hotels'            => 'tours#hotels',    as: :tour_hotels
      match 'resorts'           => 'tours#resorts',   as: :tour_resorts
      # TODO: match 'locations'   => 'tours#locations', as: :tour_comments
      # TODO: match 'prices'      => 'tours#prices',    as: :prices
    end


    resources :nodes, only: [:index, :new, :create]
    resources :nodes, path: '', except: [:index, :new, :create]
  end
end

