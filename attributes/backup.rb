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
