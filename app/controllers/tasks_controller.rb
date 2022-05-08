class TasksController < ApplicationController
  before_action:set_user,only:%i[new create index]
  before_action:logged_in_user,only:%i[show update edit]

  def new
    @task = Task.new
  end
  
  def create
    @task=@user.tasks.build(task_params)
    if @task.save
      flash[:success]="タスクを新規作成しました。"
      redirect_to user_tasks_url 
    else
      render:new
    end  
  end
  
  def index
    @tasks = @user.tasks
  end
  
  def edit 
  end  
  
  def show
    @task_id= Task.find(params[:id])
  end
  
  def update
    if @task.update_attributes(task_params)
      falsh[:success]="タスクを更新しました"
      redirect_to user_task_url @task
    else
      render:edit
    end
  end  
    
  def destroy
    @task.destroy
    flash[:success]="タスクを削除しました"
    redirect_to user_tasks_url @user
  end
  
  private
  
  #タスク一覧情報を扱います。
  def task_params
    params.require(:task).permit(:name,:description)
  end  

  def set_user
    @user = User.find(params[:user_id])
  end

  def logged_in_user
    unless logged_in?
      flash[:danger]= "ログインしてください。"
      redirect_to login_url
    end
  end  
end

