Backup Cookbook
===================
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/damm/backup?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This cookbook automates deploying the [backup](https://github.com/backup/backup) gem and the configuration of any *models* you may want.  With a little work you can backup everything using this cookbook as the framework.

Requirements
============

#### packages
- `ruby` - ruby is required for the backup gem to be installed.  This can be provided either via chef or via other means.
- `libxml2-dev`
- `libxslt1-dev`

Resources and Providers
----------

This cookbook provides three resources and corresponding providers.

`install.rb`
--------


Install or Remove the backup gem with this resource.

Actions:

* `install` - installs the backup gem
* `remove` - removes the backup gem

`generate_config.rb`
-------------

Generate a configuration file for the backup gem with this resource.

Actions:

* `setup` - sets up a basic config.rb for the backup gem
* `remove` - **removes the base directory for the backup gem** and everything underneath it.

### backup::install
<table>
  <tr>
    <th>Attribute</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>version</tt></td>
    <td>String</td>
    <td>Version of the backup gem to install</td>
    <td></td>
  </tr>
</table>

### backup::generate_config
<table>
  <tr>
    <th>Attribute</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>base_dir</tt></td>
    <td>String</td>
    <td>Path where backup and it's configuration files and models reside</td>
    <td><tt>/opt/backup</tt></td>
  </tr>
  <tr>
    <td><tt>cookbook</tt></td>
    <td>String</td>
    <td>Cookbook that has the erb template specified in the <code>source</code> to generate config.rb</td>
    <td><tt>backup</tt></td>
  </tr>
  <tr>
    <td><tt>source</tt></td>
    <td>String</td>
    <td>Filename of the erb template that generates <code>config.rb</code></td>
    <td><tt>config.rb.erb</tt></td>
  </tr>
  <tr>
    <td><tt>tmp_path</tt></td>
    <td>String</td>
    <td>Directory to store temporary files during backup</td>
    <td><tt>/tmp</tt></td>
  </tr>
  <tr>
    <td><tt>data_path</tt></td>
    <td>String</td>
    <td>Directory to store Storage Cycler YAML files</td>
    <td><tt>/opt/backup/.data</tt></td>
  </tr>
</table>

### backup::generate_model

<table>
  <tr>
    <th>Attribute</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>options</tt></td>
    <td>Hash</td>
    <td>Specifies the options used in the backup model</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>base_dir</tt></td>
    <td>String</td>
    <td>Path where backup and it's configuration files and models reside</td>
    <td><tt>/opt/backup</tt></td>
  </tr>
  <tr>
    <td><tt>gem_bin_dir</tt></td>
    <td>String</td>
    <td>Path where gem binaries, such as backup, reside (e.g. "/usr/local/bin" )</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>split_into_chunks_of</tt></td>
    <td>Fixnum</td>
    <td>Split the backup archive into multiple smaller files</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>description</tt></td>
    <td>String</td>
    <td>Description of the backup</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>backup_type</tt></td>
    <td>String</td>
    <td>What kind of backup? <a href="http://backup.github.io/backup/v4/archives/">archive</a> or <a href="http://backup.github.io/backup/v4/databases/">database</a></td>
    <td><tt>database</tt></td>
  </tr>
  <tr>
    <td><tt>database_type</tt></td>
    <td>String</td>
    <td>Type of Database to backup</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>encrypt_with</tt></td>
    <td>Hash</td>
    <td>Hash to specify how to <a href="http://backup.github.io/backup/v4/encryptors/">Encrypt</a> backups</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>compress_with</tt></td>
    <td>String</td>
    <td>Specify the Compress Methodd (or disable it)</td>
    <td>Gzip</td>
  </tr>
  <tr>
    <td><tt>store_with</tt></td>
    <td>Hash</td>
    <td>Specify what  <a href="http://backup.github.io/backup/v4/storages/">storage</a> engines you wish enable.</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>sync_with</tt></td>
    <td>Hash</td>
    <td>Enable and configure <a href="http://backup.github.io/backup/v4/syncers/">Syncers</a> for this model.</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>hour</tt></td>
    <td>String</td>
    <td>What hour to run the backup</td>
    <td><tt>1</tt></td>
  </tr>
  <tr>
    <td><tt>minute</tt></td>
    <td>String</td>
    <td>How many minutes past the hour to run the backup</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>day</tt></td>
    <td>String</td>
    <td>Day of the week to run the backup</td>
    <td><tt>*</tt></td>
  </tr>
  <tr>
    <td><tt>month</tt>
    <td>String</td>
    <td>Day of the month to run backup</td>
    <td><tt>*</tt></td>
  </tr>
  <tr>
    <td><tt>weekday</tt></td>
    <td>String</td>
    <td>Day of the Week to run backup</td>
    <td><tt>*</tt></td>
  </tr>
  <tr>
    <td><tt>mailto</tt></td>
    <td>String</td>
    <td>sets the MAILTO variable in the crontab to specify who should get the output of the crontab run</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>tmp_path</tt></td>
    <td>String</td>
    <td>sets the tmp path for the backup</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>cron_path</tt></td>
    <td>String</td>
    <td>sets the PATH variable in the crontab to specify who should get the output of the crontab run</td>
    <td>/usr/bin:/bin:/usr/local/bin:/opt/chef/embedded/bin</td>
  </tr>
  <tr>
    <td><tt>cron_log</tt></td>
    <td>String</td>
    <td>Log file for redirecting the cron job output</td>
    <td></td>
  </tr>
   <tr>
    <td><tt>before_hook</tt></td>
    <td>String</td>
    <td>Before hook runs ruby code just after 'Backup' logs that the backup has started, before any procedures are performed</td>
    <td></td>
  </tr>
   <tr>
    <td><tt>after_hook</tt></td>
    <td>String</td>
    <td>After hook runs ruby code just before any Notifiers and is guaranteed to run whether or not the backup process was successful or not</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>notify_by</tt></td>
    <td>Hash</td>
    <td>Hash object that configures <a href="http://backup.github.io/backup/v4/notifiers/">Notifiers</a></td>
    <td></td>
  </tr>
</table>

Usage
-----

This cookbook is intended to be a framework to help backup your systems.  Some examples below:

### MongoDB

```ruby
backup_install node.name
backup_generate_config node.name
gem_package "fog" do
  version "~> 1.4.0"
end
backup_generate_model "mongodb" do
  description "Our shard"
  backup_type "database"
  database_type "MongoDB"
  split_into_chunks_of 2048
  store_with({"engine" => "S3", "settings" => { "s3.access_key_id" => "example", "s3.secret_access_key" => "sample", "s3.region" => "us-east-1", "s3.bucket" => "sample", "s3.path" => "/", "s3.keep" => 10 } } )
  options({"db.host" => "\"localhost\"", "db.lock" => true})
  mailto "some@example.com"
  cron_path "/bin:/usr/bin:/usr/local/bin"
  tmp_path "/mnt/backups"
  cron_log "/var/log/backups.log"
  action :backup
end
```

### PostgreSQL

```ruby
backup_install node.name
backup_generate_config node.name
gem_package "fog" do
  version "~> 1.4.0"
end
backup_generate_model "pg" do
  description "backup of postgres"
  backup_type "database"
  database_type "PostgreSQL"
  split_into_chunks_of 2048
  store_with({"engine" => "S3", "settings" => { "s3.access_key_id" => "sample", "s3.secret_access_key" => "sample", "s3.region" => "us-east-1", "s3.bucket" => "sample", "s3.path" => "/", "s3.keep" => 10 } } )
  options({"db.name" => "\"postgres\"", "db.username" => "\"postgres\"", "db.password" => "\"somepassword\"", "db.host" => "\"localhost\"" })
  mailto "sample@example.com"
  action :backup
end
```

### Archiving files to S3

```ruby
backup_install node.name
backup_generate_config node.name
gem_package "fog" do
  version "~> 1.4.0"
end
backup_generate_model "home" do
  description "backup of /home"
  backup_type "archive"
  split_into_chunks_of 250
  store_with({"engine" => "S3", "settings" => { "s3.access_key_id" => "sample", "s3.secret_access_key" => "sample", "s3.region" => "us-east-1", "s3.bucket" => "sample", "s3.path" => "/", "s3.keep" => 10 } } )
  options({"add" => ["/home/","/root/"], "exclude" => ["/home/tmp"], "tar_options" => "-p"})
  mailto "sample@example.com"
  action :backup
end
```

### Notifications

```ruby
backup_generate_model "archive_attribute_test" do
  description "backup of /etc using additional attributes"
  backup_type "archive"
  split_into_chunks_of 250
  store_with({"engine" => "Local", "settings" => { "local.keep" => 5, "local.path" => "/tmp" } })
  options({"add" => ["/home/","/etc/"], "exclude" => ["/etc/init"], "tar_options" => "-p"})
  mailto "sample@example.com"
  action :backup
  notify_by({"method" => "Campfire", "settings" => {"campfire.on_success" => "true", "campfire.on_warning" => "true", "campfire.on_failure" => "true", "campfire.api_token" => "token", "campfire.subdomain" => "domain", "campfire.room_id" => '34' }})
  gem_bin_dir "/usr/local/bin"
  cron_path "/bin:/usr/bin:/usr/local/bin:/opt/chef/embedded/bin"
  cron_log "/var/log/backups.log"
  tmp_path "/opt/tmp/backups"
end
```

### Syncers

```ruby
backup_generate_model "sync_my_docs" do
  description  "Backup with RSync::Pull"
  action :backup
  backup_type "syncer"
  gem_bin_dir "/opt/chef/embedded/bin"
  options "add" => ["/home/username/documents", "/home/username/works"],
          "exclude" => ["tmp"]
  sync_with "syncer" => "RSync::Pull",
            "settings" => { "syncer.path" => "/opt/backup/syncs",
                            "syncer.mode" => :ssh,
                            "syncer.additional_ssh_options" => "-i /home/username/.ssh/id_rsa",
                            "syncer.host" => "192.168.0.42",
                            "syncer.ssh_user" => "username" }
end
```

> It is possible to load the settings in an *role* or an *data bag* or leave the settings in a recipe.

License and Author
-------------------

Author:: Scott Likens (<scott@likens.us>)

Copyright 2014, Scott M. Likens

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and limitations under the License.
