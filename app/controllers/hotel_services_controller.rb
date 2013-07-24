class HotelServicesController < ApplicationController
  # GET /hotel_services
  # GET /hotel_services.json
  def index
    @hotel_services = HotelService.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hotel_services }
    end
  end

  # GET /hotel_services/1
  # GET /hotel_services/1.json
  def show
    @hotel_service = HotelService.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hotel_service }
    end
  end

  # GET /hotel_services/new
  # GET /hotel_services/new.json
  def new
    @hotel_service = HotelService.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hotel_service }
    end
  end

  # GET /hotel_services/1/edit
  def edit
    @hotel_service = HotelService.find(params[:id])
  end

  # POST /hotel_services
  # POST /hotel_services.json
  def create
    @hotel_service = HotelService.new(params[:hotel_service])

    respond_to do |format|
      if @hotel_service.save
        format.html { redirect_to @hotel_service, notice: 'Hotel service was successfully created.' }
        format.json { render json: @hotel_service, status: :created, location: @hotel_service }
      else
        format.html { render action: "new" }
        format.json { render json: @hotel_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hotel_services/1
  # PUT /hotel_services/1.json
  def update
    @hotel_service = HotelService.find(params[:id])

    respond_to do |format|
      if @hotel_service.update_attributes(params[:hotel_service])
        format.html { redirect_to @hotel_service, notice: 'Hotel service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hotel_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotel_services/1
  # DELETE /hotel_services/1.json
  def destroy
    @hotel_service = HotelService.find(params[:id])
    @hotel_service.destroy

    respond_to do |format|
      format.html { redirect_to hotel_services_url }
      format.json { head :no_content }
    end
  end
end
