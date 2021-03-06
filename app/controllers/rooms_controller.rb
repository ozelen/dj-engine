class RoomsController < ApplicationController
  #load_and_authorize_resource
  before_filter :find_hotel
  layout 'hotel'#, except: [:edit, :update, :new, :create, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = @hotel.rooms

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rooms }
    end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room = Room.find params[:id]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.json
  def new
    authorize! :manage, @hotel
    @room = Room.new
    @room.hotel_id = @hotel.id
    @room.type = Type.find_by_slug('rooms')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find params[:id]
  end

  # POST /rooms
  # POST /rooms.json
  def create
    authorize! :manage, @hotel
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        format.html { redirect_to [@room.hotel, @room], notice: 'Room was successfully created.' }
        format.json { render json: @room, status: :created, location: @room }
      else
        format.html { render action: "new" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    authorize! :manage, @hotel
    @room = Room.find params[:id]
    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to [@room.hotel, @room], notice: 'Room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    authorize! :manage, @hotel
    @room = Room.find params[:id]
    @room.destroy

    respond_to do |format|
      format.html { redirect_to hotel_rooms_url }
      format.json { head :no_content }
    end
  end


end
