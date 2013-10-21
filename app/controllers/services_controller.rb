class ServicesController < ApplicationController
  load_and_authorize_resource
  before_filter :find_hotel
  layout 'hotel'
  # GET /services
  # GET /services.json
  def index
    @services = @hotel.services

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @services }
    end
  end

  # GET /services/1
  # GET /services/1.json
  def show
    @service = Service.find(params[:id])
    @hotel = @service.hotel

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/new
  # GET /services/new.json
  def new
    authorize! :manage, @hotel
    @service = Service.new
    @service.hotel_id = @hotel.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/1/edit
  def edit
    authorize! :manage, @hotel
    @service = Service.find(params[:id])
  end

  # POST /services
  # POST /services.json
  def create
    authorize! :manage, @hotel
    @service = Service.new(params[:service])

    respond_to do |format|
      if @service.save
        format.html { redirect_to hotel_service_url(@hotel, @service), notice: 'Service was successfully created.' }
        format.json { render json: @service, status: :created, location: @service }
      else
        format.html { render action: "new" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /services/1
  # PUT /services/1.json
  def update
    authorize! :manage, @hotel
    @service = Service.find(params[:id])

    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to [@service.hotel, @service], notice: 'Hotel service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    authorize! :manage, @hotel
    @service = Service.find(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to hotel_services_url }
      format.json { head :no_content }
    end
  end
end
