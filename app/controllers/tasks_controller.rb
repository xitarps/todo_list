class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = current_user.tasks.new(task_params)
    return redirect_to @task if @task.save

    render :new
  end

  def update
    @task = current_user.tasks.find(params[:id])
    return redirect_to @task, notice: 'Alterado com sucesso' if @task.update(task_params)

    render :edit
  end

  def destroy
    @task = current_user.tasks.find(params[:id])

    redirect_to tasks_path, notice: 'Apagado com sucesso' if @task.destroy
  end

  def search
    @tasks = Task.search(params[:search_term])

    render :index
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, category_ids: [])
  end
end
