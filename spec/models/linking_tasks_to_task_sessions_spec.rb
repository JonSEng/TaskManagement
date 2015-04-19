require 'spec_helper'

describe TaskSession do
  before (:each) do    @title_1 = "title 1"
    @title_2 = "title 2"
    @progress_1 = 1
    @progress_2 = 2
    @people_1 = "people 1"
    @people_2 = "people 2"
    @admin_1 = "admin 1"
    @admin_2 = "admin 2"
    @notes_1 = "notes 1"
    @notes_2 = "notes 2"

    @session = TaskSession.new
    @session.title = @title_1
    @session.progress = @progress_1
    @session.admin = @admin_1
    @session.save!

    @task_1 = Task.new
    @task_1.title = @title_1
    @task_1.progress = @progress_1
    @task_1.people = @people_1
    @task_1.notes = @notes_1
    @task_1.task_session = @session
    @task_1.save!

    @task_2 = Task.new
    @task_2.title = @title_2
    @task_2.progress = @progress_2
    @task_2.people = @people_2
    @task_2.notes = @notes_2
    @task_2.task_session = @session
    @task_2.save!
  end
  it 'can access TaskSession from Tasks' do
    @task_1.task_session.should == @session
    @task_2.task_session.should == @session
  end
  it 'can access Tasks from TaskSessions' do
    puts @session.tasks.class
    @session.tasks.size.should == 2
    @session.tasks.find(@task_1.id).should == @task_1

    @session.tasks.destroy(@task_1)
    @session.tasks.size.should == 1
  end
  it 'fails on sad path: accessing single Task from TaskSession, assuming one-to-one relationship' do
    begin
      @session.task
      fail
    rescue NoMethodError
    end
  end
  it 'fails on sad path: adding more than 1 TaskSession to a Task' do
    begin
      @task.task_session << @session
      fail
    rescue NoMethodError
    end
  end
  it 'fails on sad path: accessing more than 1 TaskSession from a Task' do
    begin
      @task.task_sessions
      fail
    rescue NoMethodError
    end
  end
end
