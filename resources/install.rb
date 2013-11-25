actions :install, :remove

attribute :version, :kind_of => String, :default => String.new

def initialize(*args)
  super
  @run_context.include_recipe ["build-essential","cron"]
  @action = :install
end
