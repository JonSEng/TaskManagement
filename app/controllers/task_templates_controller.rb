require 'controller_template'

class TaskTemplatesController < ApplicationController
  layout "application_nav_bar"
  set_model "TaskTemplate"
  before_action :set_task_template, only: [:show, :edit, :update, :destroy]

  #Makes these methods accessible from the view
  helper_method :sort_column, :sort_direction

  def index
    redirect_if_not_signed_in

    #find all relevant templates
    @task_templates = TaskTemplate.order(sort_column + ' ' + sort_direction)

  end

  def show
  end

  def new
    redirect_if_not_signed_in
    @task_template = TaskTemplate.new
  end

  def edit
  end

 private
  # Use callbacks to share common setup or constraints between actions.
  def set_task_template
    return if redirect_if_not_signed_in
    @task_template = TaskTemplate.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_template_params
    params.require(:task_template).permit(:title, :created_by, :location)
  end

  # Code for sorting behavior of the task templates table.
  # DEFAULT: Sort by date descending (most recent on top)
  def sort_column
    TaskTemplate.column_names.include?(params[:sort]) ? params[:sort] : 'date'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end
end
