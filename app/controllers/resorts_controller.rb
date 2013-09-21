class ResortsController < ApplicationController
  before_filter :find_resort, except: [:new, :create]
  layout 'resort', only: [:show, :hotels, :blog, :album]
  def index
    @resorts = Resort.all
    #@resorts = params[:stream] ? Resort.all : Stream.find_by_slug(params[:stream]).resorts

    respond_to do |format|
      format.html { render layout: 'stream' if params[:stream] }
      format.json { render json: @resorts }
    end
  end

  def album
  end

  def hotels
    @hotels = Hotel.paginate(page: params[:page], per_page: 10) # TODO: resort hotels scope
    render template: 'hotels/index'
  end

  def blog
    @posts = @resort.posts
  end

  # GET /resorts/1
  # GET /resorts/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resort }
    end
  end

  # GET /resorts/new
  # GET /resorts/new.json
  def new
    @resort = Resort.new
    @resort.node = Node.new
    @cities = City.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resort }
    end
  end

  # GET /resorts/1/edit
  def edit
  end

  # POST /resorts
  # POST /resorts.json
  def create
    @resort = Resort.new(params[:resort])

    respond_to do |format|
      if @resort.save
        format.html { redirect_to @resort, notice: 'Resort was successfully created.' }
        format.json { render json: @resort, status: :created, location: @resort }
      else
        format.html { render action: "new" }
        format.json { render json: @resort.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resorts/1
  # PUT /resorts/1.json
  def update
    respond_to do |format|
      if @resort.update_attributes(params[:resort])
        format.html { redirect_to @resort, notice: 'Resort was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resort.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resorts/1
  # DELETE /resorts/1.json
  def destroy
    @resort.destroy

    respond_to do |format|
      format.html { redirect_to resorts_url }
      format.json { head :no_content }
    end
  end

private

  def find_resort
    id = params[:id] || params[:resort_id] || params[:resort_slug]
    if id
      @node = Node.find_by_name(id)
      @resort = @node.accessible if id
    end
  end

end
