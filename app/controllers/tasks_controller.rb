class TasksController < ApplicationController
    before_action :set_todo_list
    before_action :set_task, only: [:edit, :update, :destroy]
  
    # Show all tasks for a specific todo list (Handled in TodoListsController#show)
  
    # New task form
    def new
      @task = @todo_list.tasks.build
    end
  
    # Create a new task
    def create
      @task = @todo_list.tasks.build(task_params)
      if @task.save
        redirect_to @todo_list, notice: "Task was successfully added."
      else
        render :new
      end
    end
  
    # Edit task form
    def edit
    end
  
    # Update a task
    def update
      if @task.update(task_params)
        redirect_to @todo_list, notice: "Task was successfully updated."
      else
        render :edit
      end
    end
  
    # Delete a task
    def destroy
      @task.destroy
      redirect_to @todo_list, notice: "Task was successfully deleted."
    end
  
    private
  
    def set_todo_list
      @todo_list = current_user.todo_lists.find(params[:todo_list_id])
    end
  
    def set_task
      @task = @todo_list.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to @todo_list, alert: "Task not found."
    end
  
    def task_params
      params.require(:task).permit(:description, :status, :completed_at)
    end
  end
  