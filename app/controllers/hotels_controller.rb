class HotelsController < ApplicationController
  before_filter :find_hotel, except: [:new, :my, :index, :create] # [:show, :edit, :update, :destroy, :pricelist, :edit_pricelist]
  layout 'hotel', except: [:index, :new]
  # GET /hotels
  # GET /hotels.json
  def index
    @hotels = Hotel.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html { render layout: 'stream' if params[:stream] }
      format.json { render json: @hotels }
    end
  end

  def contacts
  end

  def pricelist
    @periods = @hotel.periods.all( :order => "till desc", :limit => 5)
  end

  def albums
  end

  def album
  end

  def leads
    @leads = @hotel.leads
  end

  def edit_albums
  end

  def blog
  end

  def show_post
    @post = @hotel.posts.find_by_slug params[:slug]
  end

  def edit_pricelist
    authorize! :manage, @hotel
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
    authorize! :create, @hotel
    unless current_user.present?
      redirect_to new_user_registration_url(proceed: 'new_hotel'), notice: 'Register first'
      return
    end

    @hotel.node     = Node.new
    @hotel.user_id  = current_user.id
    @hotel.type     = Type.find_by_slug('hotels')
    @hotel.location = Location.new
    @hotel.address  = Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hotel }
    end
  end

  # GET /hotels/1/edit
  def edit
    authorize! :manage, @hotel
  end

  # POST /hotels
  # POST /hotels.json
  def create
    @hotel = Hotel.new(params[:hotel])
    authorize! :create, @hotel

    respond_to do |format|
      if @hotel.save
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
    authorize! :manage, @hotel
    respond_to do |format|
      if @hotel.update_attributes(params[:hotel])
        format.html { redirect_to @hotel, notice: 'Hotel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html {
          #redirect_to action: :edit
          render :edit
        }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    authorize! :destroy, @hotel
    @hotel.destroy

    respond_to do |format|
      format.html { redirect_to hotels_url }
      format.json { head :no_content }
    end
  end

  def find_hotel
    id = params[:id] || params[:hotel_id] || params[:hotel_slug]
    @node = Node.find_by_name(id)
    @hotel = @node.accessible if id
  end

end
