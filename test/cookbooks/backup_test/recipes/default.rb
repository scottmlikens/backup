#
# Cookbook Name:: backup
# Recipe:: example
#
# Copyright 2012, Scott M. Likens
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

backup_install node.name 
backup_generate_config node.name

gem_package "fog" do
  version "~> 1.4.0"
end

backup_generate_model "archive" do
  description "backup of /etc"
  backup_type "archive"
  split_into_chunks_of 250
  store_with({"engine" => "Local", "settings" => { "local.keep" => 5, "local.path" => "/tmp" } })
  options({"add" => ["/home/","/etc/"], "exclude" => ["/etc/init"], "tar_options" => "-p"})
  mailto "sample@example.com"
  action :backup
end

execute "backup now" do
  command "/opt/chef/embedded/bin/backup perform -t archive -c /opt/backup/config.rb"
end
