class TaskTemplate < ActiveRecord::Base

  # Due to using gem' protected_attributes', must use attr_accessible to make
  # mass-assignment work
  attr_accessible :date, :title, :created_by, :location, :created_at, :updated_at

  has_many :tasks, :class_name => Task

end
