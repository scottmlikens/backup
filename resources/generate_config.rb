actions :setup, :remove

# Password to encrypt all backups with
attribute :encryption_password, :kind_of => String, :default => nil
# Path where backup and it's configuration files and models reside
attribute :base_dir, :kind_of => String, :default => "/opt/backup"
# Cookbook that has the erb template specified in the source to generate config.rb
attribute :cookbook, :kind_of => String, :default => "backup"
# Filename of the erb template that generates config.rb 
attribute :source, :kind_of => String, :default => "config.rb.erb"

def initialize(*args)
  super
  @action = :setup
end
