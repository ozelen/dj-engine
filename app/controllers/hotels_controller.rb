class HotelsController < ApplicationController

  before_filter :find_hotel, only: [:show, :edit, :update, :destroy]
  # GET /hotels
  # GET /hotels.json
  def index
    @hotels = Hotel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hotels }
    end
  end

  def my
    @hotels = current_user.hotels
  end

  # GET /hotels/1
  # GET /hotels/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hotel }
    end
  end

  # GET /hotels/new
  # GET /hotels/new.json
  def new
    @hotel = Hotel.new
    @hotel.user_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hotel }
    end
  end

  # GET /hotels/1/edit
  def edit
  end

  # POST /hotels
  # POST /hotels.json
  def create
    @hotel = Hotel.new(params[:hotel])

    respond_to do |format|
      if @hotel.save
        @hotel.node = Node.create_from_accessible!
        format.html { redirect_to @hotel, notice: 'Hotel was successfully created.' }
        format.json { render json: @hotel, status: :created, location: @hotel }
      else
        format.html { render action: "new" }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hotels/1
  # PUT /hotels/1.json
  def update
    respond_to do |format|
      if @hotel.update_attributes(params[:hotel])
        @hotel.node.save_from_accessible! params
        format.html { redirect_to @hotel, notice: 'Hotel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    @hotel.destroy

    respond_to do |format|
      format.html { redirect_to hotels_url }
      format.json { head :no_content }
    end
  end

  def find_hotel
    @hotel = Node.find_by_name(params[:id]).accessible if params[:id]
  end

end
