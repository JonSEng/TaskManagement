require 'controller_template'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Allow users to have extra custom fields
  before_filter :configure_devise_permitted_parameters, if: :devise_controller?

  def redirect_if_not_signed_in
    if !current_user
      redirect_to root_path
      return true
    end
    return false
  end

  def after_sign_in_path_for(resource)
    task_sessions_path
  end

  def self.get_instance_variable_name(class_name)
    return "" if class_name == nil
    res = String.new(class_name)
    res.gsub!(/[Cc]ontroller$/, "")
    convert = nil
    while res != convert
      convert = res
      res.match /([^_])([A-Z])/
      break if $1 == nil or $2 == nil
      res.sub! /([^_])([A-Z])/, "#{$1}_#{$2.downcase}"
    end
    res.match /^([A-Z])/
    res.sub! /^([A-Z])/, "#{$1.downcase}" if $1 != nil
    return res
  end

  def self.get_text_name(class_name)
    return "" if class_name == ""
    snake_case_name = get_instance_variable_name(class_name)
    text_name = snake_case_name.gsub(/_/, " ")
    text_name[0] = text_name[0].upcase if text_name.length > 0
    return text_name
  end

  def task_container_path
    if params[:task_session_id]
      task_session_tasks_path
    elsif params[:task_template_id]
      task_template_tasks_path
    elsif request.fullpath =~ /task_templates/
      task_templates_path
    elsif request.fullpath =~ /task_sessions/
      task_sessions_path
    end
  end

  def task_container
    if params[:task_session_id]
      TaskSession.find_by_id(params[:task_session_id])
    elsif params[:task_template_id]
      TaskTemplate.find_by_id(params[:task_template_id])
    end
  end

  protected

  def configure_devise_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :phone_number
    devise_parameter_sanitizer.for(:account_update) << :phone_number
  end
end
