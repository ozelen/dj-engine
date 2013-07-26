class NodesController < ApplicationController
  load_and_authorize_resource find_by: :name
  before_filter :find_node, only: [:show, :edit, :update, :destroy]
  # GET /nodes
  # GET /nodes.json
  def home
  end

  def mercury_update
    @node.header = params[:content][:node_header][:value]
    @node.content = params[:content][:node_content][:value]
    @node.save!
    render text: ""
  end

  def index
    @nodes = Node.all
    @node = Node.find_by_name!('skiworld')
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
      render template: layout.pluralize + '/show'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @node }
      end
    end

  end

  def page
    @node = Node.find_by_name params[:name]
    @page_title = @node.title
    @object = @node.accessible
    layout = @node.accessible_type.parameterize
    instance_variable_set "@#{layout}", @node.accessible
    render layout: layout
  end

  # GET /nodes/new
  # GET /nodes/new.json
  def new
    @node = Node.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @node }
    end
  end

  # GET /nodes/1/edit
  def edit
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = Node.new(params[:node])

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
    @node.destroy

    respond_to do |format|
      format.html { redirect_to nodes_url }
      format.json { head :no_content }
    end
  end

private

  def find_node
    @node = Node.find_by_name!(params[:id])
  end

end
