MiniTest::Chef::Resources.register_resource(:gem_package)
describe "backup" do
  describe_recipe "backup_test::default" do
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
    it "should have the backup gem" do
      gem_package("backup").must_be_installed
    end
    it "should have a cron entry called 'scheduled backup: archive'" do
      cron("scheduled backup: archive").must_exist
    end
    it "should have the development libraries for libxml2 installed" do
      if node.platform_family.include?("rhel")
        libxml2 = "libxml2-devel"
      end
      if node.platform_family.include?("debian")
        libxml2 = "libxml2-dev"
      end
      package(libxml2).must_be_installed
    end
    it "should have the development libraries for libxslt installed" do
      if node.platform_family.include?("rhel")
        libxslt1 = "libxslt-devel"
      end
      if node.platform_family.include?("debian")
        libxslt1 = "libxslt1-dev"
      end
      package(libxslt1).must_be_installed
    end
    it "should have a directory called /tmp/archive" do
      directory("/tmp/archive").must_exist
    end
    it "should have a cron entry called 'scheduled backup: no_split_test'" do
      cron("scheduled backup: no_split_test").must_exist
    end
    it "should have a directory called /tmp/no_split_test" do
      directory("/tmp/no_split_test").must_exist
    end
    describe "should have a model file for no_split_test" do
      let(:config) { file("/opt/backup/models/no_split_test.rb") }
      it { config.must_exist }
      it { config.wont_include 'split_into_chunks_of' }
    end
    it "should have a cron entry called 'scheduled backup: archive_attribute_test'" do
      cron("scheduled backup: archive_attribute_test").must_exist
    end
    describe "should have a cron entry called 'scheduled backup: archive_attribute_test'" do
      let(:entry) { cron("scheduled backup: archive_attribute_test") }
      it { entry.must_exist }
      it { entry.must_have(:path, '/bin:/usr/bin:/usr/local/bin:/opt/chef/embedded/bin') }
      it { entry.must_have(:command, '/usr/local/bin/backup perform -t archive_attribute_test -c /opt/backup/config.rb --tmp-path /opt/tmp/backups >> /var/log/backups.log 2>&1') }
    end
    it "should have a directory called /tmp/archive_attribute_test" do
      directory("/tmp/archive_attribute_test").must_exist
    end 
  end
end
