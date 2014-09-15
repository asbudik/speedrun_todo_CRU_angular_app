class TodosController < ApplicationController
  
  respond_to :json, :html
  
  before_action :find_todo, only: [:show, :update, :destroy]

  before_action :render_main_layout_if_format_html
  def index
    respond_with Todo.all
  end

  def create
    respond_with Todo.create(todo_params)
  end

  def show
    respond_with @todo
  end

  def update
    respond_with @todo.update(todo_params)
  end

  def destroy
    respond_with @todo.destroy
  end

  private

  def todo_params
    params.require(:todo).permit(:name, :description, :completed)
  end

  def find_todo
    @todo = Todo.find(params[:id])
  end

  def render_main_layout_if_format_html
    # check the request format
    if request.format.symbol == :html
      render "layouts/application"
    end
  end
end
