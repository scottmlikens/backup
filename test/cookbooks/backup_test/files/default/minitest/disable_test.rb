MiniTest::Chef::Resources.register_resource(:gem_package)
describe "backup" do
  describe_recipe "backup_test::default" do
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
    it "should have a cron entry called 'scheduled backup: archive_attribute_test'" do
      cron("scheduled backup: archive").wont_exist
    end
    it "should not have a file called /opt/backup/models/no_split_test.rb" do
      file("/opt/backup/models/no_split_test.rb").wont_exist
    end
  end
end
