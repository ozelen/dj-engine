class PricesController < ApplicationController
  # GET /Prices
  # GET /Prices.json
  def index
    @hotel = Hotel.find params[:hotel_id]
    @room = Room.find params[:room_id]
    @prices = @room.prices

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prices }
    end
  end

  # GET /Prices/1
  # GET /Prices/1.json
  def show
    @hotel = Hotel.find params[:hotel_id]
    @room = Room.find(params[:room_id])
    @price = Price.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @price }
    end
  end

  # GET /Prices/new
  # GET /Prices/new.json
  def new
    @price = Price.new
    @room = Room.find(params[:room_id])
    @hotel = @room.hotel
    @periods = @hotel.periods
    @rooms = @hotel.rooms

    @price.room_id = @room.id
    if params.has_key? :period_id
      @period = Period.find(params[:period_id])
      if @period.hotel == @hotel
        @price.period_id = @period.id
      else
        raise 'Period does not match with the current hotel'
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @price }
    end
  end

  # GET /Prices/1/edit
  def edit
    @price = Price.find(params[:id])
    @room  = @price.room
    @hotel = @room.hotel
    @periods = @hotel.periods
    @rooms = @hotel.rooms
  end

  # POST /Prices
  # POST /Prices.json
  def create
    @price = Price.new(params[:price])
    @hotel = Hotel.find params[:hotel_id]
    @room = Room.find(params[:room_id])

    respond_to do |format|
      if @price.save
        format.html { redirect_to [@hotel, @room, @price], notice: 'Room price was successfully created.' }
        format.json { render json: @price, status: :created, location: @price }
      else
        format.html { render action: "new" }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /Prices/1
  # PUT /Prices/1.json
  def update
    @price = Price.find(params[:id])
    @room = @price.room
    @hotel = @room.hotel

    respond_to do |format|
      if @price.update_attributes(params[:price])
        format.html { redirect_to [@hotel, @room, @price], notice: 'Room price was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Prices/1
  # DELETE /Prices/1.json
  def destroy
    @price = Price.find(params[:id])
    @room = @price.room
    @hotel = @room.hotel

    @price.destroy

    respond_to do |format|
      format.html { redirect_to hotel_room_prices_url(@hotel, @room) }
      format.json { head :no_content }
    end
  end
end
