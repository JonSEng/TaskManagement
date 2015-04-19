require 'spec_helper'
require 'controller_template'

describe ApplicationController do
  before(:each) do
    @app_name = "Application"
    @task_name = "Task"
    @session_name = "TaskSession"
    @empty_string = ""
    @nil_string = nil
  end
  it "can convert class names into snake case for properly formatted class names" do
    ApplicationController.get_instance_variable_name(@app_name).should == "application"
    ApplicationController.get_instance_variable_name(@task_name).should == "task"
    ApplicationController.get_instance_variable_name(@session_name).should == "task_session"
  end
  it "can convert class names into normal text for properly formatted class names" do
    ApplicationController.get_text_name(@app_name).should == "Application"
    ApplicationController.get_text_name(@task_name).should == "Task"
    ApplicationController.get_text_name(@session_name).should == "Task session"
  end
  it "can handle sad path of an empty string for get_instance_variable_name" do
    ApplicationController.get_instance_variable_name(@empty_string).should == ""
  end
  it "can handle sad path of an nil string for get_instance_variable_name" do
    ApplicationController.get_instance_variable_name(@nil_string).should == ""
  end
  it "can handle sad path of an empty string for get_text_name" do
    ApplicationController.get_text_name(@empty_string).should == ""
  end
  it "can handle sad path of an nil string for get_text_name" do
    puts Class.methods.keep_if { |e| e =~ /get_/ }
    ApplicationController.get_text_name(@nil_string).should == ""
  end
end
