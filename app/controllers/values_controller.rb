class ValuesController < ApplicationController
  def show
    @value = Value.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @value }
      format.js
    end
  end
  
  def edit
    @value = Value.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @values }
      format.js
    end
  end
  
  def update
    @value = Value.find(params[:id])
    respond_to do |format|
      if @value.update_attributes(params[:value])
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @value.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end
end
