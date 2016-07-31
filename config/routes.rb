class SlugConstraint
  def initialize type
    @type = type
  end

  def matches? request
    node = Node.find_by_name request[@type.parameterize+'_slug']
    node && node.accessible_type == @type
  end
end

DjEngine::Application.routes.draw do



  resources :redirects


  resources :deals


  # users and authentications
  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations'
  }
  resources :authentications

  scope "(:locale)", locale: /(en|uk|ru|ua)/ do # /#{I18n.available_locales.join('|')}/ do
    # Homepage
    root :to => 'nodes#home'
    get 'home', :to => 'nodes#home'

    resources :photos

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
    get "destroy_bunch" => "comments#destroy_bunch", as: :delete_bunch_of_comments

    # Location and addresses
    get "locations/search" => "locations#search"
    resources :regions
    resources :cities

    # User sessions
    resources :user_sessions

    # User's preferences
    resources :users
    resource :user, :as   => 'account'      # a convenience route


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
      resources :deals
    end

    # shortcut to hotel by slug
    get 'hotels(/page/:page)'             => 'hotels#index', as: :hotels_path
    get ':hotel_slug'          => 'hotels#show', constraints: SlugConstraint.new('Hotel'), as: :slug_hotel
    scope ':hotel_slug', constraints: SlugConstraint.new('Hotel') do
      get 'rooms'                         => 'rooms#index',               as: :slug_hotel_rooms
      get 'rooms/:id'                     => 'rooms#show',                as: :slug_hotel_room
      get 'rooms/:id/album(/:photo_id)'   => 'rooms#show',                as: :room_album
      get 'services'                      => 'services#index',            as: :slug_hotel_services
      get 'services/:id'                  => 'services#show',             as: :slug_hotel_service
      get 'services/:id/album(/:photo_id)'=> 'rooms#show',                as: :service_album
      get 'pricelist'                     => 'hotels#pricelist',          as: :slug_hotel_pricelist
      get 'pricelist/edit'                => 'hotels#edit_pricelist',     as: :slug_edit_hotel_pricelist
      get 'album(/:photo_id)'             => 'hotels#album',              as: :hotel_album
      get 'albums/edit'                   => 'hotels#edit_albums',        as: :slug_edit_hotel_albums
      get 'comments(/page/:page)'         => 'hotels#comments',           as: :slug_hotel_comments
      get 'blog(/page/:page)'             => 'hotels#blog',               as: :slug_hotel_blog
      get 'posts/:post_id'                => 'posts#show',                as: :hotel_post
      get 'blog/tags/:tag'                => 'hotels#blog',               as: :tag
      get 'contacts'                      => 'hotels#contacts',           as: :slug_hotel_contacts
      get 'description'                   => 'hotels#description',        as: :slug_hotel_description
      get 'book'                          => 'hotels#book',               as: :slug_hotel_book
      get 'leads'                         => 'hotels#leads',              as: :hotel_leads
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

    get ':stream_slug' => 'streams#show', constraints: SlugConstraint.new('Stream'), as: :stream_slug

    scope ':stream_slug', constraints: SlugConstraint.new('Stream') do
      get 'resorts(/page/:page)'          => 'streams#resorts',     as: :stream_resorts
      get 'news(/page/:page)'             => 'streams#news',        as: :stream_news
      get 'posts/:post_id'                => 'posts#show',          as: :stream_post
      get 'blog(/page/:page)'             => 'streams#blog',        as: :stream_blog
      get 'blog/tags/:tag'                => 'streams#blog',        as: :tag
      get 'hotels'                        => 'streams#hotels',      as: :stream_hotels
      get 'tours'                         => 'streams#tours',       as: :stream_tours
    end

    # Cities
    get ':city_slug'      => 'cities#show',           as: :slug_city,          constraints: SlugConstraint.new('City')
    scope ':city_slug', constraints: SlugConstraint.new('City') do
      match 'description'                 => 'cities#description',  as: :city_description
      match 'hotels(/page/:page)'         => 'cities#hotels',       as: :city_hotels
      match 'resorts'                     => 'cities#resorts',      as: :city_resorts
      match 'location'                    => 'cities#location',     as: :city_location
      match 'album'                       => 'cities#album',        as: :city_album
      match 'comments(/page/:page)'       => 'cities#comments',     as: :city_comments
      match 'infrastructure(/:filter_types)' => 'legacies#city_infrastructure'
    end

    # Resorts
    resources :resorts
    #get 'resorts' => 'resorts#index', as: :resorts
    match ':resort_slug'    => 'resorts#show',      as: :slug_resort,          constraints: SlugConstraint.new('Resort')

    scope ':resort_slug', constraints: SlugConstraint.new('Resort') do
      match 'description'                 => 'resorts#description',  as: :resort_description
      match 'hotels(/page/:page)'         => 'resorts#hotels',       as: :resort_hotels
      match 'hotels/:city(/page/:page)'   => 'resorts#hotels_city',  as: :resort_hotels_city
      match 'blog(/page/:page)'           => 'resorts#blog',         as: :resort_blog
      match 'posts/:post_id'              => 'posts#show',           as: :resort_post
      match 'album'                       => 'resorts#album',        as: :resort_album
      match 'comments(/page/:page)'       => 'resorts#comments',     as: :resort_comments
    end

    resources :tours
    scope 'tours/:tour_id' do
      match 'album(/:photo_id)'           => 'tours#album',         as: :tour_album
      match 'comments(/page/:page)'       => 'tours#comments',      as: :tour_comments
      match 'hotels'                      => 'tours#hotels',        as: :tour_hotels
      match 'resorts'                     => 'tours#resorts',       as: :tour_resorts
      match 'contacts'                    => 'tours#contacts',      as: :tour_contacts
      match 'description'                 => 'tours#description',   as: :tour_description
      match 'blog(/page/:page)'           => 'tours#blog',          as: :tour_blog
      match 'posts/:post_id'              => 'posts#show',          as: :tour_post
      # TODO: match 'locations'           => 'tours#locations', as: :tour_comments
      # TODO: match 'prices'              => 'tours#prices',    as: :prices
    end


    #### Legacy ####

    scope '(:lang)' do
      get 'goto/:goto(/infrastructure/:filter_types)' => 'legacies#goto'
      get 'news/show/:slug' => 'legacies#news_item'
    end

    ####/Legacy ####

    #resources :nodes, only: [:index, :new, :create, :edit]
    #resources :nodes, path: '', except: [:index, :new, :create, :show]
    resources :nodes
    get '*name' => 'nodes#page', as: :slug_node
  end
end

