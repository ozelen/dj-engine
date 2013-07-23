class SourceInstancesController < ApplicationController
  # GET /source_instances
  # GET /source_instances.json
  def index
    @source_instances = SourceInstance.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @source_instances }
    end
  end

  # GET /source_instances/1
  # GET /source_instances/1.json
  def show
    @source_instance = SourceInstance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @source_instance }
    end
  end

  # GET /source_instances/new
  # GET /source_instances/new.json
  def new
    @source_instance = SourceInstance.new
    @source_instance.parent_instance_id = params[:id]
    @source_instance.parent = SourceInstance.find(params[:id]) if params[:id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @source_instance }
    end
  end

  # GET /source_instances/1/edit
  def edit
    @source_instance = SourceInstance.find(params[:id])
  end

  # POST /source_instances
  # POST /source_instances.json
  def create
    @source_instance = SourceInstance.new(params[:source_instance])

    respond_to do |format|
      if @source_instance.save
        format.html { redirect_to @source_instance, notice: 'Source instance was successfully created.' }
        format.json { render json: @source_instance, status: :created, location: @source_instance }
      else
        format.html { render action: "new" }
        format.json { render json: @source_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /source_instances/1
  # PUT /source_instances/1.json
  def update
    @source_instance = SourceInstance.find(params[:id])

    respond_to do |format|
      if @source_instance.update_attributes(params[:source_instance])
        format.html { redirect_to @source_instance, notice: 'Source instance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @source_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /source_instances/1
  # DELETE /source_instances/1.json
  def destroy
    @source_instance = SourceInstance.find(params[:id])
    @source_instance.destroy

    respond_to do |format|
      format.html { redirect_to source_instances_url }
      format.json { head :no_content }
    end
  end

end
