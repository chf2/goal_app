class UsersController < ApplicationController
  before_action :require_logged_in, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @goals = @user == current_user ? @user.goals : @user.goals.where(public: true)
    @comments = @user.comments.includes(:author)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
