# Base dir for installation (Gemfile, models, keys, etc)
default['backup']['base_dir'] = "/opt/backups"

# Backup Models
default['backup']['models'] = %w[daily]

# Chunks (used by all models)
default['backup']['split_into_chunks_of'] = 250

# Databases
default['backup']['databases'] = %w[MySQL MongoDB Redis]

# AWS
default['backup']['aws']['access_key_id'] = nil
default['backup']['aws']['secret_access_key'] = nil

# S3
default['backup']['aws']['s3']['bucket'] = nil
default['backup']['aws']['s3']['path'] = "/backups"
default['backup']['aws']['s3']['keep'] = 10

# GPG
default['backup']['gpg']['public_key'] = nil

# MySQL options
default['backup']['mysql']['database'] = :all
default['backup']['mysql']['username'] = "root"
default['backup']['mysql']['password'] = ""
# If socket is specified, we'll prefer that
default['backup']['mysql']['socket'] = "/var/run/mysqld/mysqld.sock"
default['backup']['mysql']['host'] = "localhost"
default['backup']['mysql']['port'] = 3306

# MongoDB options
default['backup']['mongodb']['database'] = :all
default['backup']['mongodb']['username'] = ""
default['backup']['mongodb']['password'] = ""
default['backup']['mongodb']['host'] = "localhost"
default['backup']['mongodb']['port'] = 27017
default['backup']['mongodb']['lock'] = true
default['backup']['mongodb']['ipv6'] = false
# Redis options
# Redis backups *MUST* be run on the machine running Redis.
# This could temporarily be a slave machine once it has finished
# synchronizing.

default['backup']['redis']['database'] = "dump"
default['backup']['redis']['path'] = "/var/lib/redis"
default['backup']['redis']['password'] = ""
default['backup']['redis']['host'] = "localhost"
default['backup']['redis']['port'] = 6379
default['backup']['redis']['invoke_save'] = true
