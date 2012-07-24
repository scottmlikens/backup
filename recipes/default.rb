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

models_dir = File.join(base_path, "models")
key_dir = File.join(base_dir, "keys")

directory base_dir
directory models_dir
directory keys_dir

gem_packge "bundler"
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
             :aws_access_key_id => node['backup']['aws']['access_key_id'],
             :aws_secret_accesss_key => node['backup']['aws']['secret_access_key'],
             :s3_bucket => node['backup']['aws']['s3']['bucket'],
             :s3_path => node['backup']['aws']['s3']['path'],
             :s3_keep => node['backup']['aws']['s3']['keep']
             )
end

node['backup']['models'].each do |backup_model|

  template File.join(models_dir, "#{backup_model}.rb") do
    variables :databases => node['backup']['databases']
  end

  cron "daily backup" do
    command "backup perform -t daily"
    path "/opt/backups/bin"
  end

end
