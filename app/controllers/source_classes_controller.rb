class SourceClassesController < ApplicationController
  # GET /source_classes
  # GET /source_classes.json
  def index
    @source_classes = SourceClass.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @source_classes }
    end
  end

  # GET /source_classes/1
  # GET /source_classes/1.json
  def show
    @source_class = SourceClass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @source_class }
    end
  end

  # GET /source_classes/new
  # GET /source_classes/new.json
  def new
    @source_class = SourceClass.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @source_class }
    end
  end

  # GET /source_classes/1/edit
  def edit
    @source_class = SourceClass.find(params[:id])
  end

  # POST /source_classes
  # POST /source_classes.json
  def create
    @source_class = SourceClass.new(params[:source_class])

    respond_to do |format|
      if @source_class.save
        format.html { redirect_to @source_class, notice: 'Source class was successfully created.' }
        format.json { render json: @source_class, status: :created, location: @source_class }
      else
        format.html { render action: "new" }
        format.json { render json: @source_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /source_classes/1
  # PUT /source_classes/1.json
  def update
    @source_class = SourceClass.find(params[:id])

    respond_to do |format|
      if @source_class.update_attributes(params[:source_class])
        format.html { redirect_to @source_class, notice: 'Source class was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @source_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /source_classes/1
  # DELETE /source_classes/1.json
  def destroy
    @source_class = SourceClass.find(params[:id])
    @source_class.destroy

    respond_to do |format|
      format.html { redirect_to source_classes_url }
      format.json { head :no_content }
    end
  end
end
