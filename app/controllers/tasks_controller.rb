class TasksController < ApplicationController
    before_action :set_todo_list
    before_action :set_task, only: [:edit, :update, :destroy, :toggle_status]
    before_action :authenticate_user!

    def create
        @task = @todo_list.tasks.build(task_params)
        if @task.save
          redirect_to @todo_list, notice: "Task added successfully."
        else
          # Show the task errors in the view by re-rendering the same page
          render "todo_lists/show", status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)
            redirect_to @todo_list, notice: "Task updated successfully."
        else
            render :edit
        end
    end

    def destroy
        @task.destroy
        redirect_to @todo_list, notice: "Task deleted."
    end

    def toggle_status
        @task.mark_completed!
        redirect_to @todo_list, notice: "Task marked as completed!"
    end

    private

    def set_todo_list
        @todo_list = current_user.todo_lists.find_by(id: params[:todo_list_id])
        # Handle the case where the todo list is not found (could redirect to 404 page, for example)
        redirect_to root_path, alert: 'Todo list not found or you do not have permission to access it.' if @todo_list.nil?
    end  

    def set_task
        @task = @todo_list.tasks.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:description, :status)
    end
end
