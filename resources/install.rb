actions :install, :remove

attribute :version, :kind_of => String, :default => nil

def initialize(*args)
  super
  @action = :install
end
