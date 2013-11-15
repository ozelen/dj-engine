class RedirectsController < ApplicationController
  load_and_authorize_resource
  # GET /redirects
  # GET /redirects.json
  def index
    @redirects = Redirect.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @redirects }
    end
  end

  # GET /redirects/1
  # GET /redirects/1.json
  def show
    @redirect = Redirect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @redirect }
    end
  end

  # GET /redirects/new
  # GET /redirects/new.json
  def new
    @redirect = Redirect.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @redirect }
    end
  end

  # GET /redirects/1/edit
  def edit
    @redirect = Redirect.find(params[:id])
  end

  # POST /redirects
  # POST /redirects.json
  def create
    @redirect = Redirect.new(params[:redirect])

    respond_to do |format|
      if @redirect.save
        format.html { redirect_to @redirect, notice: 'Redirect was successfully created.' }
        format.json { render json: @redirect, status: :created, location: @redirect }
      else
        format.html { render action: "new" }
        format.json { render json: @redirect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /redirects/1
  # PUT /redirects/1.json
  def update
    @redirect = Redirect.find(params[:id])

    respond_to do |format|
      if @redirect.update_attributes(params[:redirect])
        format.html { redirect_to @redirect, notice: 'Redirect was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @redirect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /redirects/1
  # DELETE /redirects/1.json
  def destroy
    @redirect = Redirect.find(params[:id])
    @redirect.destroy

    respond_to do |format|
      format.html { redirect_to redirects_url }
      format.json { head :no_content }
    end
  end
end
