class UsersController < ApplicationController
  # before_filter :signed_in_user, 
  #               only: [:index, :edit, :update, :destroy, :following, :followers]
  # before_filter :correct_user,   only: [:edit, :update]
  # before_filter :admin_user,     only: :destroy
  # before_filter :unsigned_in_user, only: [:new, :create]

  def show
  	@user = User.find(params[:id])
  end

  private

    # def admin_user
    #   redirect_to(root_path) unless current_user.admin? #&& !current_user?(@user)
    # end

    # def correct_user
    #   @user = User.find(params[:id])
    #   redirect_to(root_path) unless current_user?(@user)
    # end

    # def unsigned_in_user
    #   redirect_to(root_path) unless !signed_in?
    # end
end