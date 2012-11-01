action :backup do
  cron "scheduled backup: " + new_resource.name do
    hour new_resource.hour || "1" 
    minute new_resource.minute || "*"
    day new_resource.day || "*"
    month new_resource.month || "*"
    weekday new_resource.weekday || "*"
    mailto new_resource.mailto 
    command "backup perform -t #{new_resource.name} -c #{new_resource.base_dir}/config.rb"
    path new_resource.base_dir
    action :nothing
  end
  template "#{new_resource.base_dir}/models/#{new_resource.name}.rb" do
    mode 0600
    source new_resource.options["source"] || "generic_model.conf.erb"
    cookbook new_resource.options["cookbook"] || "backup"
    variables({
                :name => new_resource.name, 
                :options => new_resource.options,
                :base_dir => new_resource.base_dir,
                :split_into_chunks_of => new_resource.split_into_chunks_of,
                :description => new_resource.description,
                :backup_type => new_resource.backup_type,
                :database_type => new_resource.database_type,
                :store_with => new_resource.store_with
              })
    notifies :create, resources(:cron => "scheduled backup: " + new_resource.name), :immediately
  end
  new_resource.updated_by_last_action(true)
end

action :disable do
  cron "scheduled backup: " + current_resource.name do
    action :remove
  end
  new_resource.updated_by_last_action(true)
end

action :remove do
  file "#{new_resource.base_dir}/models/#{new_resource.name}.rb" do
    action :remove
  end
  cron "scheduled backup: " + current_resource.name do
    action :remove
  end
  new_resource.updated_by_last_action(true)
end
