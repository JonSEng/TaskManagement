require 'spec_helper'

describe Task do
  before (:each) do
    @title_1 = "title 1"
    @title_2 = "title 2"
    @progress_1 = 1
    @progress_2 = 2
    @people_1 = "people 1"
    @people_2 = "people 2"
    @notes_1 = "notes 1"
    @notes_2 = "notes 2"
  end
  it "can create tasks properly" do
    task = Task.new
    task.title = @title_1
    task.progress = @progress_1
    task.people = @people_1
    task.notes = @notes_1
    task.save!
  end
  it "can access a created task properly when only one task exists" do
    task = Task.new
    task.title = @title_1
    task.progress = @progress_1
    task.people = @people_1
    task.notes = @notes_1
    task.save!

    Task.find_by_title(@title_1).should == task
    Task.find_by_progress(@progress_1).should == task
    Task.find_by_people(@people_1).should == task
    Task.find_by_notes(@notes_1).should == task
  end
  it "can access created tasks properly when other tasks exist" do
    task_1 = Task.new
    task_1.title = @title_1
    task_1.progress = @progress_1
    task_1.people = @people_1
    task_1.notes = @notes_1
    task_1.save!

    task_2 = Task.new
    task_2.title = @title_2
    task_2.progress = @progress_2
    task_2.people = @people_2
    task_2.notes = @notes_2
    task_2.save!

    Task.find_by_title(@title_1).should == task_1
    Task.find_by_progress(@progress_1).should == task_1
    Task.find_by_people(@people_1).should == task_1
    Task.find_by_notes(@notes_1).should == task_1

    Task.find_by_title(@title_2).should == task_2
    Task.find_by_progress(@progress_2).should == task_2
    Task.find_by_people(@people_2).should == task_2
    Task.find_by_notes(@notes_2).should == task_2
  end
  it "can access lists of created tasks properly" do
    task_1 = Task.new
    task_1.title = @title_1
    task_1.progress = @progress_1
    task_1.people = @people_1
    task_1.notes = @notes_1
    task_1.save!

    task_2 = Task.new
    task_2.title = @title_2
    task_2.progress = @progress_1
    task_2.people = @people_2
    task_2.notes = @notes_2
    task_2.save!

    Task.where(progress: @progress_1).to_a.length.should == 2
    Task.where(progress: @progress_1).to_a[0].should == task_1
    Task.where(progress: @progress_1).to_a[1].should == task_2
  end
end
