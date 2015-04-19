json.array!(@task_sessions) do |task_session|
  json.extract! task_session, :title, :progress, :admin
  json.url task_session_url(task_session, format: :json)
end
