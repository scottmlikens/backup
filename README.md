Backup Cookbook
===================
[![Build Status](https://travis-ci.org/damm/backup.svg?branch=master)](https://travis-ci.org/damm/backup)

This cookbook automates deploying the [backup](https://github.com/backup/backup) gem and the configuration of any *models* you may want.  With a little work you can backup everything using this cookbook as the framework.

Requirements
============

#### packages
- `ruby` - ruby is required for the backup gem to be installed.
> Note Currently Chef13 ships Ruby 2.4 in it's Omnnibus which is not compatable with the Backup gem currently
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
| Attribute  | Type  | Description  | Default  | Required |
|---|---|---|---|---|
| version | String | Version of the backup gem to install | 4.4.0 | No |

### backup::generate_config
| Attribute  | Type  | Description  | Default  | Required |
|---|---|---|---|---|
| base_dir | String | Path where backup adn it's configuration files and models resize | /opt/backup | No |
| cookbook | String | Cookbook that has the erb template specified in the <code>source</code> to generate config.rb | backup | No |
| source | String | Filename of the erb template that generates <code>config.rb</code> | config.rb.erb | No |
| tmp_path | String | Directory to store temporary files during backup | /tmp | No |
| data_path | String | Directory to store Storage Cycler Yaml Files | /opt/backup/.data | No |

### backup::generate_model
| Attribute  | Type  | Description  | Default  | Required |
|---|---|---|---|---|
| options | Hash | Specifies the options used in the backup model | `{}` | Yes |
| base_dir | String | Path where backup and it's configuration files and models reside | /opt/backup | No |
| gem_bin_dir | String | Path where gem binaries end up.  (e.g. /usr/local/bin) | | No |
| split_into_chunks_of | Fixnum | Split the backup archives into multiple smaller files | | No |
| description | String | Description of the backup | | No |
| backup_type | String | What kind of backup? [archive](http://backup.github.io/backup/v4/archives/) or [database](http://backup.github.io/backup/v4/databases) | database | Yes |
| database_type | String | Type of Database to backup | | Yes |
| encrypt_with | Hash | Hash to specify how to [Encrypt](http://backup.github.io/backup/v4/encryptors/) | | No |
| compress_with | String | Specify the Comrpession Method (or disable it) | Gzip | |
| store_with | Hash | Specify what [storage](http://backup.github.io/backup/v4/storages/) engines you wish use | `{}` | Yes |
| sync_with | Hash | Enable and configure [syncers](http://backup.github.io/backup/v4/syncers/) for this model.</td> | `{}` | No |
| hour | String | What hour to run the backup | 1 | No |
| minute | String | How many minutes past the hour to run the backup | 0 | No |
| month | String | Day of the month to run backup | * | No |
| weekday | String | Day of the week to run backup | * | No |
| mailto | String | sets the MAILTO variable in the crontab to specify who should get the output of the crontab run | | No |
| tmp_path | String | sets the tmp path for the backup | | No |
| cron_path | String | sets the PATH variable in the crontab | | No |
| cron_log | String | Log file for redirecting the job output | | No |
| before_hook | String | Before hook runs ruby code just after _Backup_ logs that the backup has started, before any procedures are performed | | No|
| after_hook | String | After hook runs ruby code just before any Notifiers and is guranteed to run wether or not the backup process was successful or not | | No |
| notify_by | Hash | Hash object that configures [Notifiers](http://backup.github.io/backup/v4/notifiers/) | | No |
| sync_with | Hash | Hash object that configures [Syncers](http://backup.github.io/backup/v4/syncers) | | No |
| storage_class | String | Symbol that specifies the [storage class](http://backup.github.io/backup/v4/storage-s3/) with with S3 | | No |

Usage
-----

This cookbook is intended to be a framework to help backup your systems.  Some examples below:

### MongoDB

```ruby
package "ruby-full"
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
package "ruby-full"
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
  options({"db.name" => "\"postgres\"", "db.username" => "\"postgres\"", "db.password" => "\"somepassword\"", "db.host" => "\"localhost\"", "db.additional_options" => "[\" --format custom \"]"})
  mailto "sample@example.com"
  action :backup
end
```

### Archiving files to S3

```ruby
package "ruby-full"
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
package "ruby-full"
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
package "ruby-full"
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

Copyright 2014-2017, Scott M. Likens

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and limitations under the License.
