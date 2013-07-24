class RoomPricesController < ApplicationController
  # GET /room_prices
  # GET /room_prices.json
  def index
    @room_prices = RoomPrice.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @room_prices }
    end
  end

  # GET /room_prices/1
  # GET /room_prices/1.json
  def show
    @room_price = RoomPrice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room_price }
    end
  end

  # GET /room_prices/new
  # GET /room_prices/new.json
  def new
    @room_price = RoomPrice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @room_price }
    end
  end

  # GET /room_prices/1/edit
  def edit
    @room_price = RoomPrice.find(params[:id])
  end

  # POST /room_prices
  # POST /room_prices.json
  def create
    @room_price = RoomPrice.new(params[:room_price])

    respond_to do |format|
      if @room_price.save
        format.html { redirect_to @room_price, notice: 'Room price was successfully created.' }
        format.json { render json: @room_price, status: :created, location: @room_price }
      else
        format.html { render action: "new" }
        format.json { render json: @room_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /room_prices/1
  # PUT /room_prices/1.json
  def update
    @room_price = RoomPrice.find(params[:id])

    respond_to do |format|
      if @room_price.update_attributes(params[:room_price])
        format.html { redirect_to @room_price, notice: 'Room price was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @room_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_prices/1
  # DELETE /room_prices/1.json
  def destroy
    @room_price = RoomPrice.find(params[:id])
    @room_price.destroy

    respond_to do |format|
      format.html { redirect_to room_prices_url }
      format.json { head :no_content }
    end
  end
end
