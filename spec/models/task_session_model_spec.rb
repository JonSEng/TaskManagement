require 'spec_helper'

describe TaskSession do
  before (:each) do
    @title_1 = "title 1"
    @title_2 = "title 2"
    @progress_1 = 1
    @progress_2 = 2
    @admin_1 = "admin 1"
    @admin_2 = "admin 2"
  end
  it "can create task sessions properly" do
    session = TaskSession.new
    session.title = @title_1
    session.progress = @progress_1
    session.admin = @admin_1
    session.save!
  end
  it "can access a created task session properly when only one task session exists" do
    session = TaskSession.new
    session.title = @title_1
    session.progress = @progress_1
    session.admin = @admin_1
    session.save!

    TaskSession.find_by_title(@title_1).should == session
    TaskSession.find_by_progress(@progress_1).should == session
    TaskSession.find_by_admin(@admin_1).should == session
  end
  it "can access created task session properly when other task sessions exist" do
    session_1 = TaskSession.new
    session_1.title = @title_1
    session_1.progress = @progress_1
    session_1.admin = @admin_1
    session_1.save!

    session_2 = TaskSession.new
    session_2.title = @title_2
    session_2.progress = @progress_2
    session_2.admin = @admin_2
    session_2.save!

    TaskSession.find_by_title(@title_1).should == session_1
    TaskSession.find_by_progress(@progress_1).should == session_1
    TaskSession.find_by_admin(@admin_1).should == session_1

    TaskSession.find_by_title(@title_2).should == session_2
    TaskSession.find_by_progress(@progress_2).should == session_2
    TaskSession.find_by_admin(@admin_2).should == session_2
  end
  it "can access lists of created tasks properly" do
    session_1 = TaskSession.new
    session_1.title = @title_1
    session_1.progress = @progress_1
    session_1.admin = @admin_1
    session_1.save!

    session_2 = TaskSession.new
    session_2.title = @title_2
    session_2.progress = @progress_1
    session_2.admin = @admin_2
    session_2.save!

    TaskSession.where(progress: @progress_1).to_a.length.should == 2
    TaskSession.where(progress: @progress_1).to_a[0].should == session_1
    TaskSession.where(progress: @progress_1).to_a[1].should == session_2
  end
end
