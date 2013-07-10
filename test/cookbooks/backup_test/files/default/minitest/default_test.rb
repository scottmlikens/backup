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
  end
end
