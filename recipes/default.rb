#
# Cookbook Name:: backup
# Recipe:: default
#
# Copyright 2012, AJ Christensen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Back that shit up

base_dir = node['backup']['base_dir']

models_dir = File.join(base_dir, "models")
keys_dir = File.join(base_dir, "keys")

directory base_dir
directory models_dir
directory keys_dir

gem_package "bundler"
execute "backup: bundle install" do
  command "bundle install --deployment --binstubs"
  cwd base_dir
  action :nothing
end

cookbook_file File.join(base_dir, "Gemfile") do
  notifies :run, resources(:execute => "backup: bundle install"), :immediately
end

template File.join(base_dir, "config.rb") do
  variables( :databases => node['backup']['databases'],
             # AWS
             :aws_access_key_id => node['backup']['aws']['access_key_id'],
             :aws_secret_accesss_key => node['backup']['aws']['secret_access_key'],
             # S3
             :s3_bucket => node['backup']['aws']['s3']['bucket'],
             :s3_path => node['backup']['aws']['s3']['path'],
             :s3_keep => node['backup']['aws']['s3']['keep'],
             # MySQL
             :mysql_database => node['backup']['mysql']['database'],
             :mysql_username => node['backup']['mysql']['username'],
             :mysql_password => node['backup']['mysql']['password'],
             :mysql_host => node['backup']['mysql']['host'],
             :mysql_port => node['backup']['mysql']['port'],
             # MongoDB
             :mongodb_database => node['backup']['mongodb']['database'],
             :mongodb_username => node['backup']['mongodb']['username'],
             :mongodb_password => node['backup']['mongodb']['password'],
             :mongodb_host => node['backup']['mongodb']['host'],
             :mongodb_port => node['backup']['mongodb']['port'],
             :mongodb_lock => node['backup']['mongodb']['lock'],
             :mongodb_ipv6 => node['backup']['mongodb']['ipv6'],
             # Redis
             :redis_database => node['backup']['redis']['database'],
             :redis_path => node['backup']['redis']['path'],
             :redis_password => node['backup']['redis']['password'],
             :redis_host => node['backup']['redis']['host'],
             :redis_port => node['backup']['redis']['port'],
             :redis_invoke_save => node['backup']['redis']['invoke_save'],
             )
end

file File.join(keys_dir, "backups.public.gpg") do
  content node['backup']['gpg']['public_key']
end

node['backup']['models'].each do |backup_model|

  template File.join(models_dir, "#{backup_model}.rb") do
    variables( :backup_model => backup_model.to_sym,
               :databases => node['backup']['databases'],
               :split_into_chunks_of => node['backup']['split_into_chunks_of']
               )
  end

  # TODO: determine schedule from model
  cron "scheduled backup: #{backup_model}" do
    hour "*/1"
    minute "0"
    command "bundle exec backup perform -t #{backup_model}"
    path "/opt/backups/bin"
  end

end
