def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

action :setup do
  %w{keys .data models logs}.each do |p|
    directory "#{new_resource.base_dir}/#{p}" do
      action :create
      recursive true
    end
  end
  
  template "#{new_resource.base_dir}/config.rb" do
    source new_resource.source
    cookbook new_resource.cookbook
    variables({
                :root_path => new_resource.base_dir,
                :tmp_path => new_resource.tmp_path,
                :data_path => new_resource.data_path
              })
  end
end

action :remove do
  directory new_resource.base_dir do
    action :delete
    recursive true
  end
end

