Description
===========

This cookbook aims to provide a foundation for you to **backup** your infrastructure.  This cookbook helps you deploy the [backup](https://github.com/meskyanichi/backup) gem and generate the models to back up.

Requirements
============

Ruby installed either in the system or via omnibus

Resources and Providers
=======================

This cookbook provides three resources and corresponding providers.

`install.rb`
-------------

Install or Remove the backup gem with this resource.

Actions:

* `install` - installs the backup gem
* `remove` - removes the backup gem

Attribute Parameters:

* `version` - specify the version of the backup gem to install

`generate_config.rb`
-------------

Generate a configuration file for the backup gem with this resource.

Actions: 

* `setup` - sets up a basic config.rb for the backup gem
* `remove` - **removes the base directory for the backup gem** and everything underneath it.

Attribute Parameters:

* `base_dir` - String - default to `/opt/backup`
* `encryption_password` - String - Provide a passphrase for [Encryption](https://github.com/meskyanichi/backup/wiki/Encryptors) - default of `nil`

`generate_model.rb`
-------------

Generates a model file for the backup gem and creates a crontab entry.

Actions:

* `backup` - Generate a model file 
* `disable` - Disable the scheduled cron for the model
* `remove` - Remove the model from the system and the scheduled cron.


Attribute Parameters:

* `base_dir` - String - default to `/opt/backup`   
* `split_into_chunks_of` - Fixnum - defaults to 250  
* `description` - String - Description of backup   
* `backup_type` - String - Type of backup to perform.  Current options supported are `{database|archive}`  
* `store_with` - Hash - Specifies how to store the backups  
* `database_type` - String - If backing up a database, what [Type](https://github.com/meskyanichi/backup/wiki/Databases) of database is being backed up.    
* `hour` - String - Hour to run the scheduled backup - default - `1`  
* `minute` - String - Minute to run the scheduled backup - default - `*`  
* `day` - String - Day to run the scheduled backup - default - `*`  
* `weekday` - String - Weekday to run the scheduled backup - default - `*`  
* `mailto` - String - Enables the cron resource to mail the output of the backup output.  


Usage
=====

There is an ininite ways you can implement this cookbook into your environment in theory.  An working example might be,

* Backing up MongoDB to S3
  1. Ensure your mongodb cookbook depends on the backup cookbook
  2. Add the following to your mongodb cookbook

        backup_install node.name  
        backup_generate_config node.name  
        package "libxml2-dev"  
        package "libxslt1-dev"  
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
          action :backup  
        end  
      

* Backing up PostgreSQL to S3
  1. Ensure your postgresql cookbook depends on the backup cookbook
  2. Add the following to your postgresql cookbook
  
        backup_install node.name  
        backup_generate_config node.name  
        package "libxml2-dev"  
        package "libxslt1-dev"  
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

* Backing up Files to S3
  1. Ensure the cookbook are updating depends on the backup cookbook.
  2. Add the following to that cookbook
  
        backup_install node.name   
        backup_generate_config node.name  
        package "libxml2-dev"  
        package "libxslt1-dev"  
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

* There is no technical reason you cannot load more of this code in via an `role` or an `data bag` instead.

License and Author
==================

Author:: Scott Likens (<scott@likens.us>)

Copyright 2012, Scott M. Likens, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0
    
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
    
    
Special Credit and Thanks
==================

Thank You [Heavy Water](hw-ops.com) for contributing the original [backup](https://github.com/hw-cookbooks/backup) cookbook.  
