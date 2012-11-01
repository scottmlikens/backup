action :install do
  chef_gem "backup" do
    action :install
    version new_resource.version
  end
  new_resource.updated_by_last_action(true)
end

action :remove do
  chef_gem "backup" do
    action :remove
  end
  new_resource.updated_by_last_action(true)
end
