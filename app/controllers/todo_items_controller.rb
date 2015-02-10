class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, except: [:create] # see have the code in create method, no need to call before
  
  def create 
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    redirect_to @todo_list
  end

  def destroy
    #move it to te set_todo_item method
    #@todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
      flash[:success] = "Todo List item was deleted"
    else
      flash[:error] = "Todo List item couldn't be deleted"
    end
    redirect_to @todo_list #rollback to the todo_list page after delete
  end

  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: "Todo item complete"
  end

  private 

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  #it's used multiple times(in destroy and now complete), so we move it out and call before
  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end

end
