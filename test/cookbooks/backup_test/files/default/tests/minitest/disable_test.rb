MiniTest::Chef::Resources.register_resource(:gem_package)
describe "backup" do
  describe_recipe "backup_test::default" do
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
    it "should have /opt/backup" do
      directory("/opt/backup").must_exist
    end
    it "should have /opt/backup/config.rb" do
      file("/opt/backup/config.rb").must_exist
    end
    it "should not have /etc/cron.d/archive" do
      file("/etc/cron.d/archive").wont_exist
    end
    it "should not have a model for archive in /opt/backup/models" do
      file("/opt/backup/models/archive.rb").wont_exist
    end
    it "should not have a file called /opt/backup/models/no_split_test.rb" do
      file("/opt/backup/models/no_split_test.rb").wont_exist
    end
    it "should not have /etc/cron.d/no_split_test" do
      file("/etc/cron.d/no_split_test").wont_exist
    end
  end
end
