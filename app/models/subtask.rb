class Subtask < ActiveRecord::Base
  belongs_to :task
  has_and_belongs_to_many :workers

  attr_accessible :title, :description, :task_id, :finished

  def make_copy
    subtask_params = {}
    subtask_params[:title] = self.title
    subtask_params[:description] = self.description
    subtask_params[:finished] = self.finished
    return Subtask.create(subtask_params)
  end

end
