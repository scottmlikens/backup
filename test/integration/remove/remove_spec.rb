control '1 backup model should be removed' do
  # it should have the archive cron and models available
  describe file("/etc/cron.d/archive") do
    it { should be_file }
  end
  describe file("/opt/backup/models/archive.rb") do
    it { should be_file }
  end
  describe file("/etc/cron.d/no_split_test") do
    it { should_not be_file }
  end
  describe file("/opt/backup/models/no_split_test.rb") do
    it { should_not be_file }
  end
end
