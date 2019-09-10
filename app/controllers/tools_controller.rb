class ToolsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_tool, only: %i[show edit update destroy]

  def index
    @tools = policy_scope(Tool)
  end

  def show
    redirect_to tools_path if @tool.nil?
  end

  def new
    @tool = Tool.new
    authorize @tool
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.user = current_user
    authorize @tool
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
    @tool.destroy
    flash.notice = "Tool has been deleted."
    redirect_to tools_path
  end

  protected

  def set_tool
    @tool = Tool.find(params[:id])
    authorize @tool
  rescue ActiveRecord::RecordNotFound
    flash.alert = "We couldn't find that tool."
    redirect_to tools_path
  rescue Pundit::NotAuthorizedError
    flash.alert = "You are not allowed to do this action."
    redirect_to tools_path
  end

  def tool_params
    params.require(:tool).permit(:name, :description, :photo)
  end
end
