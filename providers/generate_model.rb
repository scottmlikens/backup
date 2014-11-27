def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

action :backup do
  # Upgrade Cycler data path to v4
  execute "mv /root/backup/data #{new_resource.base_dir}/.data" do
    only_if { ::File.exist?("/root/backup/data") }
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
                :store_with => new_resource.store_with,
                :encrypt_with => new_resource.encrypt_with,
                :after_hook => new_resource.after_hook
              })
  end
  cron_d new_resource.name do
    hour new_resource.hour || "1" 
    minute new_resource.minute || "*"
    day new_resource.day || "*"
    month new_resource.month || "*"
    weekday new_resource.weekday || "*"
    mailto new_resource.mailto
    # if node['languages']['ruby'].empty?
    #   cmd = "/opt/chef/embedded/bin/backup perform -t #{new_resource.name} -c #{new_resource.base_dir}/config.rb"
    if new_resource.gem_bin_dir
      cmd = "#{new_resource.gem_bin_dir}/backup perform -t #{new_resource.name} -c #{new_resource.base_dir}/config.rb"
    else
      cmd = "#{node['languages']['ruby']['bin_dir']}/backup perform -t #{new_resource.name} -c #{new_resource.base_dir}/config.rb"
    end
    command cmd + ( new_resource.tmp_path ? " --tmp-path #{new_resource.tmp_path}" : "" ) +  ( new_resource.cron_log ? " >> #{new_resource.cron_log} 2>&1" : "" )
    if new_resource.cron_path
      path new_resource.cron_path
    else
      path node['languages']['ruby']['bin_dir']
    end
    action :create
  end
  # We delete the old crontab if it's hanging around as we moved to cron_d
  cron new_resource.name do
    action :delete
  end
end

action :disable do
  cron_d new_resource.name do
    action :delete
  end
end

action :remove do
  file "#{new_resource.base_dir}/models/#{new_resource.name}.rb" do
    action :delete
  end
  cron_d new_resource.name do
    action :delete
  end
end
