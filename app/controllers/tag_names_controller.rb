class TagNamesController < ApplicationController
  load_and_authorize_resource
  # GET /tag_names
  # GET /tag_names.json
  def index
    @tag_names = TagName.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tag_names }
    end
  end

  # GET /tag_names/1
  # GET /tag_names/1.json
  def show
    @tag_name = TagName.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag_name }
    end
  end

  # GET /tag_names/new
  # GET /tag_names/new.json
  def new
    @tag_name = TagName.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag_name }
    end
  end

  # GET /tag_names/1/edit
  def edit
    @tag_name = TagName.find(params[:id])
  end

  # POST /tag_names
  # POST /tag_names.json
  def create
    @tag_name = TagName.new(params[:tag_name])

    respond_to do |format|
      if @tag_name.save
        format.html { redirect_to @tag_name, notice: 'Tag name was successfully created.' }
        format.json { render json: @tag_name, status: :created, location: @tag_name }
      else
        format.html { render action: "new" }
        format.json { render json: @tag_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tag_names/1
  # PUT /tag_names/1.json
  def update
    @tag_name = TagName.find(params[:id])

    respond_to do |format|
      if @tag_name.update_attributes(params[:tag_name])
        format.html { redirect_to @tag_name, notice: 'Tag name was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_names/1
  # DELETE /tag_names/1.json
  def destroy
    @tag_name = TagName.find(params[:id])
    @tag_name.destroy

    respond_to do |format|
      format.html { redirect_to tag_names_url }
      format.json { head :no_content }
    end
  end
end
