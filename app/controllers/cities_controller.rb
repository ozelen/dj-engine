class CitiesController < ApplicationController
  #load_and_authorize_resource
  # GET /cities
  # GET /cities.json
  before_filter :find_city, except: [:new, :my, :index, :create]
  layout 'city', except: [:index, :new, :edit]
  def index
    @cities = City.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cities }
    end
  end

  def hotels
    @hotels = @city.hotels.paginate(page: params[:page], per_page: 20)
    #render template: 'hotels/index'
  end

  def comments
    @comments = @city.comments.latest.paginate(page: params[:page], per_page: 20).to_a
  end

  def location
  end

  def album
  end

  # GET /cities/1
  # GET /cities/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @city }
    end
  end

  def description
  end

  def resorts
  end

  # GET /cities/new
  # GET /cities/new.json
  def new
    authorize! :create, @city
    @city = City.new
    @city.location = Location.new
    @city.node =  Node.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @city }
    end
  end

  # GET /cities/1/edit
  def edit
    authorize! :manage, @city
  end

  # POST /cities
  # POST /cities.json
  def create
    authorize! :create, @city
    @city = City.new(params[:city])

    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: 'City was successfully created.' }
        format.json { render json: @city, status: :created, location: @city }
      else
        format.html { render action: "new" }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cities/1
  # PUT /cities/1.json
  def update
    authorize! :manage, @city
    respond_to do |format|
      if @city.update_attributes(params[:city])
        @city.node.save_from_accessible! params
        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    authorize! :destroy, @city
    @city.destroy

    respond_to do |format|
      format.html { redirect_to cities_url }
      format.json { head :no_content }
    end
  end

  def find_city
    id = params[:id] || params[:city_id] || params[:city_slug]
    @node = Node.find_by_name(id)
    @city = @node.accessible if id
  end

end
