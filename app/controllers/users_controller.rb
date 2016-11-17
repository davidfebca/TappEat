class UsersController < ApplicationController
  before_action :authenticate_user! ,:except => [:public_profile]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def public_profile
    @user = User.find_by id: params[:id]
    unless @user
      redirect_to not_found_path
      return
    end
  end
  
end
