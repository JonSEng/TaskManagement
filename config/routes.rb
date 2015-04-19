GpTaskManagement::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", :confirmations => "devise_confirmations", :passwords => "devise_passwords", :registrations => "devise_registrations", :sessions => "devise_sessions", :unlocks => "devise_unlocks"}

  root :to =>'welcome#index'

  resources :task_sessions, :task_templates do
    resources :tasks, :except => [:new, :create, :destroy, :edit] do
      resources :subtasks
    end

    match '/tasks/:id/edit_task', :action => "edit_task", :via => [:get, :post], :controller => 'tasks'
    match '/tasks/delete_subtask/:subtask_id', :action => 'delete_subtask', :via => [:get, :post], :controller => 'tasks'
    match '/tasks/add_task', :action =>'add_task', :via => [:post], :controller => 'tasks'
    match '/tasks/:id/delete_task', :action =>'delete_task', :via => [:get, :post], :controller => 'tasks'
    match '/import/:import_template_name', :action =>'import', :via => [:get, :post], :controller => 'tasks'
    match '/tasks/:id/add_subtask', :action => 'add_subtask', :via => [:get, :post], :controller => "tasks"
    match '/tasks/:id/update_subtasks', :action => 'update_subtasks', :via => [:get, :post], :controller => "tasks", :as => "task_update_subtasks"
  end

  resources :task_sessions do
    match '/tasks/:id/done', :action =>'complete', :via => [:put], :controller => 'tasks', :as => "done"
    match '/save', :action =>'save', :via => [:get, :post], :controller => 'task_sessions'

    match '/tasks/:id/assign_leader', :action =>'assign_leader', :via => [:get, :post], :controller => 'tasks', :as => "task_assign_leader"
    match '/tasks/:id/assign_worker', :action =>'assign_worker', :via => [:get, :post], :controller => 'tasks', :as => "task_assign_worker"
    match '/tasks/add_worker', :action =>'add_worker', :via => [:get, :post], :controller => 'tasks'
    match '/tasks/:id/move_worker', :controller => 'tasks', :action =>'move_worker', :via => [:get, :post], :as => "move_worker"
    match '/unassign_worker', :controller => 'tasks', :action =>'unassign_worker', :via => [:get, :post], :as => "unassign_worker"
    match '/remove_worker', :controller => 'tasks', :action =>'remove_worker', :via => [:get, :post], :as => "remove_worker"
  end

end
