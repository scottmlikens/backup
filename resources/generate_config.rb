actions :setup, :remove

attribute :encryption_password, :kind_of => String, :default => nil
attribute :base_dir, :kind_of => String, :default => "/opt/backup"

def initialize(*args)
  super
  @action = :setup
end
