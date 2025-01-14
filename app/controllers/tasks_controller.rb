class TasksController < ApplicationController
  before_action :set_task, except: [:create]
  
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to tasks_path
      return
    end
    
  end
  
  def new
    @task = Task.new
  end
  
  
  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed])
    #instantiate a new task
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id)
      # go to the show page for the newly created path
      return
    else # save failed :(
      render :new # show the new task form view again
      return
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    elsif @task.update(name: params[:task][:name], description: params[:task][:description], completed: params[:task][:completed])
      redirect_to task_path # go to the task show page so we can see the updates in place
      return
    else # save failed :(
      render :edit # show the edit task form view again
      return
    end
  end
  
  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to root_path
      return
    end
    
    @task.destroy
    
    redirect_to tasks_path

    return
  end
  
  def complete
    @task.update_attribute(:completed, Time.now)
    redirect_to tasks_path, notice: "Task completed"
   end
  
  private 
  
  def task_params
    return params.require(:task).permit(:name, :description, :completed)
  end
  

  def set_task
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
   end

end

