class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :admin_only, :except => :show

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    #if current user is not the admin
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end
  
  private

  #unless the current user is the admin, access is denied
  def admin_only
    @user = User.find(1)
    unless current_user.admin?
     #unless user #1(admin) is the current user, access is denied
     unless @user == current_user
      redirect_to :back, :alert => "Access denied."
     end
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

end
