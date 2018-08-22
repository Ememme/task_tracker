# frozen_string_literal: true

# frozen_string_literal: true

# Handle tasks
class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.all
  end

  def search
    render json: Task.where('subject LIKE ?', "#{params[:query]}%").pluck(:subject)
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path
    else
      @tasks = Task.all
      render action: :index
    end
  end

  private

  def task_params
    params.require(:task).permit(:subject)
  end
end
