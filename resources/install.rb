actions :install, :remove

# Version of the backup gem to install
attribute :version, :kind_of => String, :default => "4.4.0"

def initialize(*args)
  super
  @run_context.include_recipe ["build-essential","cron"]
  @action = :install
end
