class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    redirect_to root_url, :alert => "Access denied." if !current_user || !current_user.role?(:admin)
    @users = User.all
  end

  def new
    @user = User.new
    @user.address = Address.new
  end

  def create
    @user = User.new(params[:user])
    @user.managed_by_admin if current_user.role? :admin
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
    @user.managed_by_admin if current_user.role? :admin
    return if trying_to_takeover

    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice  => "Successfully updated profile."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    return if trying_to_takeover
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed user."
  end

  # fuck off a user which trying to fuck the founder off :)
  def trying_to_takeover
    @user.email == 'ozelen@djerelo.info' && current_user.email != 'ozelen@djerelo.info'
  end
end
