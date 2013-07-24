class ServicesController < ApplicationController
  # GET /services
  # GET /services.json
  def index
    @hotel = Hotel.find params[:hotel_id]
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
    @hotel = @service.hotel || Hotel.find(params[:hotel_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/new
  # GET /services/new.json
  def new
    @service = Service.new
    @hotel = Hotel.find params[:hotel_id]
    @service.hotel_id = @hotel.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/1/edit
  def edit
    @service = Service.find(params[:id])
    @hotel = Hotel.find params[:hotel_id]
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(params[:service])
    @hotel = Hotel.find(params[:hotel_id])

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
    @service = Service.find(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to hotel_services_url }
      format.json { head :no_content }
    end
  end
end
