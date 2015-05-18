class GoalsController < ApplicationController
  before_action :require_logged_in
  before_action :require_correct_user, except: [:new, :create]

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      flash[:success] = "Goal created!"
      redirect_to current_user
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to current_user
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    goal = Goal.find(params[:id])
    goal.destroy
    redirect_to current_user
  end

  def toggle
    goal = Goal.find(params[:id])
    goal.toggle!(:completed)

    redirect_to current_user
  end

  private

  def goal_params
    params.require(:goal).permit(:body, :public)
  end

  def require_correct_user
    unless Goal.find(params[:id]).user_id == current_user.id
      flash[:warning] = "Stop that."
      redirect_to current_user
    end
  end
end
