json.array!(@tasks) do |task|
  json.extract! task, :title, :progress, :people, :notes
  json.url task_session_task_url(task, format: :json)
end
