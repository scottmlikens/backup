actions :install, :remove

attribute :version, :kind_of => String, :default => String.new

def initialize(*args)
  super
  @action = :install
end
