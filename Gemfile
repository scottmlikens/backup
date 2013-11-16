source 'https://rubygems.org'

gem 'rake'
gem 'rspec'
gem 'foodcritic'
gem 'berkshelf'
gem 'thor-foodcritic'
gem 'vagrant-wrapper'

group :integration do
  gem 'test-kitchen',    '~> 1.0.0.beta'
  gem 'kitchen-vagrant', :git => "git://github.com/opscode/kitchen-vagrant.git"
  gem 'kitchen-ec2', :git => "git://github.com/opscode/kitchen-ec2.git"
  gem 'kitchen-lxc', :git => "https://github.com/portertech/kitchen-lxc.git", :tag => 'v0.0.1.beta2'
end
