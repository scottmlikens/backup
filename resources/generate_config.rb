actions :setup, :remove

attribute :encryption_password, :kind_of => String, :default => nil
attribute :base_dir, :kind_of => String, :default => "/opt/backup"
attribute :cookbook, :kind_of => String, :default => "backup"
attribute :source, :kind_of => String, :default => "config.rb.erb"

def initialize(*args)
  super
  @action = :setup
end
