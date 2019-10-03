class TasksController < ApplicationController
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
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
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
      redirect_to tasks_path
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(
      name: params[:task][:name], 
      description: params[:task][:description], 
      completion_date: params[:task][:completion_date]
    )
      redirect_to tasks_path # go to the index so we can see the updated task in the list of all tasks
      return
    else # save failed :(
      render :edit # show the edit task form view again
      return
    end
  end

end
