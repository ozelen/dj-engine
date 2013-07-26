class RoomsController < ApplicationController
  #load_and_authorize_resource
  before_filter :find_hotel#
  before_filter :find_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = @hotel.rooms

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rooms }
    end
  end

  def layout
    @node = Node.find_by_name params[:ident]
    @object = @node.accessible
    @rooms = @object.rooms
    render layout: 'hotel', template: 'nodes/page'
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
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
    @room.node = Node.new
    @room.hotel_id = @hotel.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        @room.node = Node.create_from_accessible! params
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
    respond_to do |format|
      if @room.update_attributes(params[:room])
        @room.node.save_from_accessible! params
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
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.json { head :no_content }
    end
  end

  def find_room
    @room = Node.find_by_name(params[:id]).accessible
  end

end
