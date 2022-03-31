class TasksController < ApplicationController
  
  def new
    @task = Task.new
  end
  
  def create 
    params[:content]
    redirect_to tasks_index_url
  end
  
  def index
    @task = @current_user.tasks
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
end

