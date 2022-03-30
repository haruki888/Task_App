class TasksController < ApplicationController
  
  def new
    
  end
  
  def index
    @tasks = @user.tasks
  end
  
  
end

