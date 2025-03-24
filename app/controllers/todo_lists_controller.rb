class TodoListsController < ApplicationController
    before_action :set_todo_list, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user! # Ensure the user is logged in
  
    # Show all todo lists for the logged-in user
    def index
      @todo_lists = current_user.todo_lists
    end
  
    # Show a single todo list with its tasks
    def show
      @tasks = @todo_list.tasks
    end
  
    # New todo list form
    def new
      @todo_list = TodoList.new
      render "new"
    end
  
    # Create a new todo list
    def create
      @todo_list = current_user.todo_lists.build(todo_list_params)
      if @todo_list.save
        redirect_to @todo_list, notice: "Todo List was successfully created."
      else
        render :new
      end
    end
  
    # Edit form for a todo list
    def edit
    end
  
    # Update a todo list
    def update
      if @todo_list.update(todo_list_params)
        redirect_to @todo_list, notice: "Todo List was successfully updated."
      else
        render :edit
      end
    end
  
    # Delete a todo list
    def destroy
      @todo_list.destroy
      redirect_to todo_lists_path, notice: "Todo List was successfully deleted."
    end
  
    private
  
    def set_todo_list
      @todo_list = current_user.todo_lists.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to todo_lists_path, alert: "Todo List not found."
    end
  
    def todo_list_params
      params.require(:todo_list).permit(:title)
    end
  end
  