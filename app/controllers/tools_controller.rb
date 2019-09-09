class ToolsController < ApplicationController
  before_action :set_tool, only: %i[show edit update destroy]

  def index
    @tools = Tool.all
  end

  def show
  end

  def new
    @tool = Tool.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def set_tool
    @tool = Tool.find(params[:id])
  end
end
