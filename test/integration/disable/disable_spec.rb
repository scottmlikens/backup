control 'backup should be disabled' do
  describe file("/opt/backup") do
    it { should be_directory }
  end
  describe file("/opt/backup/config.rb") do
    it { should be_file }
  end
  describe file("/etc/cron.d/archive") do
    it { should_not be_file }
  end
  describe file("/opt/backup/models/archive.rb") do
    it { should_not be_file }
  end
  describe file("/opt/backup/models/no_split_test.rb") do
    it { should_not be_file }
  end
  describe file("/etc/cron.d/no_split_test") do
    it { should_not be_file }
  end
end
