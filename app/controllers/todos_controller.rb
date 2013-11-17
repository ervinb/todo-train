class TodosController < ApplicationController
  # attr_accessible is moved here in Rails 4
  # and it's implemented below
  private

  def todo_params
  	params.require(:todo)
  end

  # the controller actions
  public

  def index
    @todo_items = Todo.all
    @new_todo = Todo.new
  end
  
  def delete
    t = Todo.last
    t.delete
  end
  
  def create
   	todo = Todo.create(:todo_item => todo_params[:todo_item])

   	if !todo.valid?
   		flash[:error] = todo.errors.full_messages.join("<br>").html_safe
   	else
   		flash[:success] = "Task added successfully!"
   	end
  	
  	redirect_to :action => 'index'
  end

  def complete
  	checkboxes = params[:todos_checkbox]
  	unless checkboxes == nil
	  	checkboxes.each do |check|
	  		todo_id = check
	  		t = Todo.find(todo_id)
	  		t.update_attribute(:completed, !t.completed)
	  	end
	end

  	redirect_to :action => "index"
  end

end
