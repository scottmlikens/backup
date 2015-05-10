def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

action :install do

  lzmadev = value_for_platform(
    ["centos","redhat","suse","fedora"] => { "default" => "xz-devel" },
    ["debian","ubuntu"] => { "default" => "liblzma-dev" }
  )
  zlibdev = value_for_platform(
    ["centos","redhat","suse","fedora"] => { "default" => "zlib-devel" },
    ["debian","ubuntu"] => { "default" => "zlib1g-dev" }
  )
  libxslt1 = value_for_platform(
    ["centos", "redhat", "suse", "fedora" ] => { "default" => "libxslt-devel" },
    ["debian", "ubuntu" ] => { "default" => "libxslt1-dev" }
  )

  libxml2 = value_for_platform(
    ["centos", "redhat", "suse", "fedora" ] => { "default" => "libxml2-devel" },
    ["debian", "ubuntu" ] => { "default" => "libxml2-dev" }
  )
  package libxml2
  package libxslt1
  package zlibdev
  package lzmadev
  gem_package "backup" do
    action :install
    version new_resource.version unless new_resource.version.empty?
  end
end

action :remove do
  gem "backup" do
    action :remove
  end
end
