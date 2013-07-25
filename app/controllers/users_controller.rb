class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    redirect_to root_url, :alert => "Access denied." if !current_user || !current_user.role?(:admin)
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Registration successful."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = params[:id] ? User.find(params[:id]) : current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice  => "Successfully updated profile."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed user."
  end
end
