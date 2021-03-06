class StreamsController < ApplicationController
  before_filter :find_stream, except: [:new, :create]
  layout 'stream', except: [:index, :new]
  # GET /streams
  # GET /streams.json
  def index
    @streams = Stream.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @streams }
    end
  end

  def blog
  end

  def tagged(klass)
    klass.tagged_with(@stream_id).paginate(page: params[:page], per_page: 10)
  end

  def news
    @posts = self.tagged(Post)
  end

  def tours
    @tours = self.tagged(Tour)
  end

  def resorts
    @resorts = self.tagged(Resort)
  end

  def hotels
    @hotels = self.tagged(Hotel)
  end

  # GET /streams/1
  # GET /streams/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stream }
    end
  end

  # GET /streams/new
  # GET /streams/new.json
  def new
    @stream = Stream.new
    @stream.node = Node.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stream }
    end
  end

  # GET /streams/1/edit
  def edit
  end

  # POST /streams
  # POST /streams.json
  def create
    @stream = Stream.new(params[:stream])

    respond_to do |format|
      if @stream.save
        format.html { redirect_to @stream, notice: 'Stream was successfully created.' }
        format.json { render json: @stream, status: :created, location: @stream }
      else
        format.html { render action: "new" }
        format.json { render json: @stream.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /streams/1
  # PUT /streams/1.json
  def update
    respond_to do |format|
      if @stream.update_attributes(params[:stream])
        format.html { redirect_to @stream, notice: 'Stream was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stream.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /streams/1
  # DELETE /streams/1.json
  def destroy
    @stream.destroy

    respond_to do |format|
      format.html { redirect_to streams_url }
      format.json { head :no_content }
    end
  end

  def find_stream
    @stream_id = params[:stream_id] || params[:stream_slug] || params[:@stream_id]
    #render text: params; return
    if @stream_id
      @node = Node.find_by_name(@stream_id)
      @stream = @node.accessible if @stream_id
    end
  end

end
