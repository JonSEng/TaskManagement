json.array!(@task_templates) do |task_template|
  json.extract! task_template, :title, :created_by
  json.url task_template_url(task_template, format: :json)
end
