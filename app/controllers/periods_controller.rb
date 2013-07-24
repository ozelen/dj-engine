class PeriodsController < ApplicationController
  # GET /periods
  # GET /periods.json
  def index
    @hotel = Hotel.find params[:hotel_id]
    @periods = @hotel.periods

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @periods }
    end
  end

  # GET /periods/1
  # GET /periods/1.json
  def show
    @hotel = Hotel.find params[:hotel_id]
    @period = Period.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @period }
    end
  end

  # GET /periods/new
  # GET /periods/new.json
  def new
    @hotel = Hotel.find params[:hotel_id]
    @period = Period.new
    @period.hotel_id = @hotel.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @period }
    end
  end

  # GET /periods/1/edit
  def edit
    @hotel = Hotel.find params[:hotel_id]
    @period = Period.find(params[:id])
  end

  # POST /periods
  # POST /periods.json
  def create
    @hotel = Hotel.find params[:hotel_id]
    @period = Period.new(params[:period])

    respond_to do |format|
      if @period.save
        format.html { redirect_to [@hotel, @period], notice: 'Period was successfully created.' }
        format.json { render json: @period, status: :created, location: @period }
      else
        format.html { render action: "new" }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /periods/1
  # PUT /periods/1.json
  def update
    @hotel = Hotel.find params[:hotel_id]
    @period = Period.find(params[:id])

    respond_to do |format|
      if @period.update_attributes(params[:period])
        format.html { redirect_to [@hotel, @period], notice: 'Period was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @hotel = Hotel.find params[:hotel_id]
    @period = Period.find(params[:id])
    @period.destroy

    respond_to do |format|
      format.html { redirect_to hotel_periods_url @hotel }
      format.json { head :no_content }
    end
  end
end
