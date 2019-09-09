class ToolsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_tool, only: %i[show edit update destroy]

  def index
    @tools = Tool.all
  end

  def show
    redirect_to tools_path if @tool.nil?
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.user = current_user
    if @tool.save
      flash.notice = "New tool created."
      redirect_to tool_path @tool
    else
      p @tool.errors
      flash.alert = "The information you entered is incomplete."
      render :new
    end
  end

  def edit
  end

  def update
    if @tool.update(tool_params)
      flash.notice = "Tool has been updated."
      redirect_to tool_path @tool
    else
      p @tool.errors
      flash.alert = "The information you entered is incomplete."
      render :edit
    end
  end

  def destroy
  end

  protected

  def set_tool
    @tool = Tool.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.alert = "We couldn't find that tool."
    redirect_to tools_path
  end

  def tool_params
    params.require(:tool).permit(:name, :description, :photo)
  end
end
