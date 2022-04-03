class TasksController < ApplicationController
  
  def new
    @task = Task.new
  end
  
  def create
    @task= Task.new(content:params[:content])
    @task.save
    redirect_to tasks_index_url
  end
  
  def index
    @task = @current_user.tasks
    @tasks =Task.all.order(created_at: :desc)
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
end

