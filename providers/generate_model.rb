begin
  use_inline_resources
rescue
end

action :backup do
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
  end
  cron "scheduled backup: " + new_resource.name do
    hour new_resource.hour || "1" 
    minute new_resource.minute || "*"
    day new_resource.day || "*"
    month new_resource.month || "*"
    weekday new_resource.weekday || "*"
    mailto new_resource.mailto
    if node['languages']['ruby'].empty?
      command "/opt/chef/embedded/bin/backup perform -t #{new_resource.name} -c #{new_resource.base_dir}/config.rb"
    else
      command "#{node['languages']['ruby']['bin_dir']}/backup perform -t #{new_resource.name} -c #{new_resource.base_dir}/config.rb"
    end
    path new_resource.base_dir
    action :create
  end
end

action :disable do
  cron "scheduled backup: " + current_resource.name do
    action :remove
  end
end

action :remove do
  file "#{new_resource.base_dir}/models/#{new_resource.name}.rb" do
    action :remove
  end
  cron "scheduled backup: " + current_resource.name do
    action :remove
  end
end
