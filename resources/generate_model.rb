actions :backup, :disable, :remove

# Specifies the options used in the backup model
attribute :options, :kind_of => Hash
# Path where backup and it's configuration files and models reside
attribute :base_dir, :kind_of => String, :default => "/opt/backup"
# Path where gem binaries, such as backup, reside
attribute :gem_bin_dir, :kind_of => String, :default => nil
# Split the backup archive into multiple smaller files
attribute :split_into_chunks_of, :kind_of => Fixnum, :default => nil
# Description of the backup
attribute :description, :kind_of => String, :default => nil
# What kind of backup? archive or database
attribute :backup_type, :kind_of => String, :default => "database"
# Type of Database to backup
attribute :database_type, :kind_of => String, :default => nil
# Specify what storage engines you wish enable.
attribute :store_with, :kind_of => Hash
# What hour to run the backup
attribute :hour, :kind_of => String, :default => "1"
# What minute to run the backup
attribute :minute, :kind_of => String, :default => "0"
# What day to run the backup
attribute :day, :kind_of => String, :default => "*"
# What day of the month to run the backup
attribute :month, :kind_of => String, :default => "*"
# What day of the week to run the backup
attribute :weekday, :kind_of => String, :default => "*"
# sets the MAILTO variable in the crontab to specify who should get the output of the crontab run
attribute :mailto, :kind_of => String, :default => nil
# sets the tmp path for the backup
attribute :tmp_path, :kind_of => String, :default => nil
# sets the PATH variable in the crontab to specify who should get the output of the crontab run
attribute :cron_path, :kind_of => String, :default => "/usr/bin:/bin:/usr/local/bin"
# Log file for redirecting the cron job output
attribute :cron_log, :kind_of => String, :default => nil
# Before hook runs ruby code just after 'Backup' logs that the backup has started, before any procedures are performed
attribute :before_hook, :kind_of => String, :default => nil
# After hook runs ruby code just before any Notifiers and is guaranteed to run whether or not the backup process was successful or not
attribute :after_hook, :kind_of => String, :default => nil
# encrypt_with.  Ruby Hash to specify how to encrypt your backups
attribute :encrypt_with, :kind_of => Hash
# Select the Compression Method (or disable it)
attribute :compress_with
# notify_by.  Ruby hash to specify how to notify your backups are completed
attribute :notify_by, :kind_of => Hash
# Enable and configure backup Syncers
attribute :sync_with, :kind_of => Hash

def initialize(*args)
  super
  @action = :nothing
end
