class NodesController < ApplicationController
  before_filter :find_node, only: [:show, :edit, :update, :destroy]
  # GET /nodes
  # GET /nodes.json
  def home
    @hotels = Hotel.limit(10)
    @comments = Comment.latest.limit(5)
  end

  def index
    @nodes = Node.where(accessible_type: nil).paginate(page: params[:page], per_page: 20)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nodes }
    end
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
    @page_title = @node.title
    if @node.accessible
      layout = @node.accessible_type.parameterize
      instance_variable_set "@#{layout}", @node.accessible
      render template: layout.pluralize + '/show', layout: layout
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @node }
      end
    end
  end

  def show_by_slug
    @node = Node.find_by_name params[:slug]
    render :show
  end

  def page
    @node = Node.find_by_name params[:name]
    if @node
      @page_title = @node.title
      if @node.accessible
        @object = @node.accessible
        layout = @node.accessible_type.parameterize
        instance_variable_set "@#{layout}", @node.accessible
        render layout: layout
      end
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  # GET /nodes/new
  # GET /nodes/new.json
  def new
    @node = Node.new
    authorize! :create, @node
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @node }
    end
  end

  # GET /nodes/1/edit
  def edit
    @node = Node.find params[:id]
    authorize! :manage, @node
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = Node.new(params[:node])
    authorize! :create, @node

    respond_to do |format|
      if @node.save
        format.html { redirect_to @node, notice: 'Node was successfully created.' }
        format.json { render json: @node, status: :created, location: @node }
      else
        format.html { render action: "new" }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nodes/1
  # PUT /nodes/1.json
  def update
    authorize! :manage, @node

    respond_to do |format|
      if @node.update_attributes(params[:node])
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    authorize! :destroy, @node

    @node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_url }
      format.json { head :no_content }
    end
  end

private

  def find_node
    @node = Node.find(params[:id])
  end

end
