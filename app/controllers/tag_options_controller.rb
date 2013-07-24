class TagOptionsController < ApplicationController
  # GET /tag_options
  # GET /tag_options.json
  def index
    @tag_options = TagOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tag_options }
    end
  end

  # GET /tag_options/1
  # GET /tag_options/1.json
  def show
    @tag_option = TagOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag_option }
    end
  end

  # GET /tag_options/new
  # GET /tag_options/new.json
  def new
    @tag_option = TagOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag_option }
    end
  end

  # GET /tag_options/1/edit
  def edit
    @tag_option = TagOption.find(params[:id])
  end

  # POST /tag_options
  # POST /tag_options.json
  def create
    @tag_option = TagOption.new(params[:tag_option])

    respond_to do |format|
      if @tag_option.save
        format.html { redirect_to @tag_option, notice: 'Tag option was successfully created.' }
        format.json { render json: @tag_option, status: :created, location: @tag_option }
      else
        format.html { render action: "new" }
        format.json { render json: @tag_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tag_options/1
  # PUT /tag_options/1.json
  def update
    @tag_option = TagOption.find(params[:id])

    respond_to do |format|
      if @tag_option.update_attributes(params[:tag_option])
        format.html { redirect_to @tag_option, notice: 'Tag option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_options/1
  # DELETE /tag_options/1.json
  def destroy
    @tag_option = TagOption.find(params[:id])
    @tag_option.destroy

    respond_to do |format|
      format.html { redirect_to tag_options_url }
      format.json { head :no_content }
    end
  end
end
