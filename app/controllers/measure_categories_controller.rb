class MeasureCategoriesController < ApplicationController
  # GET /measure_categories
  # GET /measure_categories.json
  def index
    @measure_categories = MeasureCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @measure_categories }
    end
  end

  # GET /measure_categories/1
  # GET /measure_categories/1.json
  def show
    @measure_category = MeasureCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @measure_category }
    end
  end

  # GET /measure_categories/new
  # GET /measure_categories/new.json
  def new
    @measure_category = MeasureCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @measure_category }
    end
  end

  # GET /measure_categories/1/edit
  def edit
    @measure_category = MeasureCategory.find(params[:id])
  end

  # POST /measure_categories
  # POST /measure_categories.json
  def create
    @measure_category = MeasureCategory.new(params[:measure_category])

    respond_to do |format|
      if @measure_category.save
        format.html { redirect_to @measure_category, notice: 'Measure category was successfully created.' }
        format.json { render json: @measure_category, status: :created, location: @measure_category }
      else
        format.html { render action: "new" }
        format.json { render json: @measure_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /measure_categories/1
  # PUT /measure_categories/1.json
  def update
    @measure_category = MeasureCategory.find(params[:id])

    respond_to do |format|
      if @measure_category.update_attributes(params[:measure_category])
        format.html { redirect_to @measure_category, notice: 'Measure category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @measure_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /measure_categories/1
  # DELETE /measure_categories/1.json
  def destroy
    @measure_category = MeasureCategory.find(params[:id])
    @measure_category.destroy

    respond_to do |format|
      format.html { redirect_to measure_categories_url }
      format.json { head :no_content }
    end
  end
end
