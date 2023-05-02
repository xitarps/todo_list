class Api::V1::TasksController < Api::V1::ApplicationController
  before_action :fetch_task, only: %i[show]

  def index
    @tasks = Task.all
  end

  def show; end

  def create
    @task = @user.tasks.new(task_params)

    if @task.save
      render :show
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  private

  def fetch_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
