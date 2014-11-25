MiniTest::Chef::Resources.register_resource(:gem_package)
describe "backup" do
  describe_recipe "backup_test::default" do
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
    # TODO: Fix this test
    #    it "should have the backup gem" do
    #      gem_package("backup").must_be_installed
    #    end
    it "should have a cron entry called 'archive'" do
      file("/etc/cron.d/archive").must_exist
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
    it "should have a directory called /tmp/archive_encrypted" do
      directory("/tmp/archive_encrypted").must_exist
    end
    it "should have a cron entry called 'archive'" do
      file("/etc/cron.d/archive").must_exist
    end
    it "should have a cron entry called 'archive'" do
      file("/etc/cron.d/archive_encrypted").must_exist
    end
    it "should have a cron entry called 'no_split_test'" do
      file("/etc/cron.d/no_split_test").must_exist
    end
    it "should have a directory called /tmp/no_split_test" do
      directory("/tmp/no_split_test").must_exist
    end
    describe "should have a model file for no_split_test" do
      let(:config) { file("/opt/backup/models/no_split_test.rb") }
      it { config.must_exist }
      it { config.wont_include 'split_into_chunks_of' }
    end
    describe "should have a model with encryption" do
      let(:config) { file("/opt/backup/models/archive_encrypted.rb") }
      it { config.must_exist }
      it { config.must_include 'encrypt_with OpenSSL' }
    end
    it "should have a cron entry called 'archive_attribute_test'" do
      file("/etc/cron.d/archive_attribute_test").must_exist
    end
    describe "should have a cron entry called 'archive_attribute_test'" do
      let(:entry) { file("/etc/cron.d/archive_attribute_test") }
      it { entry.must_exist }
      it { entry.must_match('/bin:/usr/bin:/usr/local/bin:/opt/chef/embedded/bin') }
      it { entry.must_match('/usr/local/bin/backup perform -t archive_attribute_test -c /opt/backup/config.rb --tmp-path /opt/tmp/backups >> /var/log/backups.log 2>&1') }
    end
    it "should have a directory called /tmp/archive_attribute_test" do
      directory("/tmp/archive_attribute_test").must_exist
    end 
  end
end
