name             "backup"
maintainer       "Scott M. Likens"
maintainer_email "scott@likens.us"
license          "Apache 2.0"
description      "Installs/Configures backup"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.0"

%w{redhat centos fedora debian ubuntu}.each do |os|
  supports os
end

%w{build-essential cron}.each do |cb|
  depends cb
end
