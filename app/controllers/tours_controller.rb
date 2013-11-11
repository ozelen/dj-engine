class ToursController < ApplicationController
  layout 'tour', except: [:index, :new]
  before_filter :find_tour, except: [:new, :create, :index]

  def contacts
  end

  def description
  end

  def index
    @tours = Tour.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tours }
    end
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
    @tour = Tour.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tour }
    end
  end

  # GET /tours/new
  # GET /tours/new.json
  def new
    @tour = Tour.new
    @tour.address = Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tour }
    end
  end

  # GET /tours/1/edit
  def edit
    @tour = Tour.find(params[:id])
  end

  def blog
    @posts = @tour.posts
  end

  # POST /tours
  # POST /tours.json
  def create
    @tour = Tour.new(params[:tour])

    respond_to do |format|
      if @tour.save
        format.html { redirect_to @tour, notice: 'Tour was successfully created.' }
        format.json { render json: @tour, status: :created, location: @tour }
      else
        format.html { render action: "new" }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tours/1
  # PUT /tours/1.json
  def update
    @tour = Tour.find(params[:id])

    respond_to do |format|
      if @tour.update_attributes(params[:tour])
        format.html { redirect_to @tour, notice: 'Tour was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.json
  def destroy
    @tour = Tour.find(params[:id])
    @tour.destroy

    respond_to do |format|
      format.html { redirect_to tours_url }
      format.json { head :no_content }
    end
  end

  def hotels
    @hotels = @tour.hotels
  end

  def resorts
    @tour = Tour.find(params[:tour_id])
    @resorts = @tour.resorts
  end

  def prices
  end

  def album
  end

  def comments
  end

  def locations
  end

  def find_tour
    id = params[:tour_id] || params[:id] || params[:tour]
    @tour = Tour.find(id)
  end

end
