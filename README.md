Backup Cookbook
===================

This cookbook automates deploying the [backup](https://github.com/meskyanichi/backup) gem and the configuration of any *models* you may want.  With a little work you can backup everything using this cookbook as the framework.

Requirements
============

#### packages
- `chef` - Chef 11+
> Due to usage of use_inline_resources.
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
    <td><tt>encryption_password</tt></td>
    <td>String</td>
    <td>Password to encrypt all backups with</td>
    <td></td>
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
    <td></td>
  </tr>
  <tr>
    <td><tt>gem_bin_dir</tt></td>
    <td>String</td>
    <td>Path where gem binaries, such as backup, reside</td>
    <td>></td>
    <td></td>
  <tr>
    <td><tt>split_into_chunks_of</tt></td>
    <td>Fixnum</td>
    <td>Split the backup archive into multiple smaller files</td>
    <td><tt>250</tt></td>
  </tr>
  <tr>
    <td><tt>description</tt></td>
    <td>String</td>
    <td>Description of the backup</td>
  </tr>
  <tr>
    <td><tt>backup_type</tt></td>
    <td>String</td>
    <td>What kind of backup? <a href="https://github.com/meskyanichi/backup/wiki/Archives">archive</a> or <a href="https://github.com/meskyanichi/backup/wiki/Databases">database</a></td>
    <td><tt>database</tt></td>
  </tr>
  <tr>
    <td><tt>database_type</tt></td>
    <td>String</td>
    <td>Type of Database to backup</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>store_with</tt></td>
    <td>Hash</td>
    <td>Specify what  <a href="https://github.com/meskyanichi/backup/wiki/Storages">storage</a> engines you wish enable.</td>
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
    <td><tt>*</tt></td>
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
    <td></td>
  </tr>
  <tr>
    <td><tt>cron_log</tt></td>
    <td>String</td>
    <td>Log file for redirecting the cron job output</td>
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

> It is possible to load the settings in an *role* or an *data bag* or leave the settings in a recipe.

License and Author
-------------------

Author:: Scott Likens (<scott@likens.us>)

Copyright 2013, Scott M. Likens

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0
    
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and limitations under the License.
