actions :backup, :disable, :remove

attribute :options, :kind_of => Hash
attribute :base_dir, :kind_of => String, :default => "/opt/backup"
attribute :split_into_chunks_of, :kind_of => Fixnum, :default => 250
attribute :description, :kind_of => String, :default => nil
attribute :backup_type, :kind_of => String, :default => "database"
attribute :database_type, :kind_of => String, :default => nil
attribute :store_with, :kind_of => Hash
attribute :hour, :kind_of => String, :default => "1"
attribute :minute, :kind_of => String, :default => "*"
attribute :day, :kind_of => String, :default => "*"
attribute :month, :kind_of => String, :default => "*"
attribute :weekday, :kind_of => String, :default => "*"
attribute :mailto, :kind_of => String, :default => nil

def initialize(*args)
  super
  @action = :nothing
end
