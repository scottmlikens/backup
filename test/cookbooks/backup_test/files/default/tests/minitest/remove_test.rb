MiniTest::Chef::Resources.register_resource(:gem_package)
describe "backup" do
  describe_recipe "backup_test::default" do
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
    it "should not have /opt/backup" do
      directory("/opt/backup").wont_exist
    end
    # Removing the configuration should not remove the crons.  Let's validate our failure.
    it "should have /etc/cron.d/archive" do
      file("/etc/cron.d/archive").must_exist
    end
    it "should not have /etc/cron.d/no_split_test" do
      file("/etc/cron.d/no_split_test").wont_exist
    end
  end
end
