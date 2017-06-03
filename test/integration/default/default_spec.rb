control 'ruby 2.3 full should be installed for the backup gem' do
  describe package('ruby-full') do
    it { should be_installed }
  end
end
control 'backup should be installed and configured' do
  describe gem('backup', '/usr/bin/gem') do
    it { should be_installed }
  end
  describe file('/opt/backup/config.rb') do
    it { should be_file }
    its(:content) { should match /data_path \'\/opt\/backup\/.data'/ }
    its(:content) { should match /tmp_path  \'\/tmp'/ }
    its(:content) { should match /root_path \'\/opt\/backup'/ }
  end
  describe package('libxml2-dev') do
    it { should be_installed }
  end
  describe package('libxslt1-dev') do
    it { should be_installed }
  end
  # Our Crons should exist
  describe file('/etc/cron.d/archive_attribute_test') do
    it { should be_file }
    its(:content) { should match /\/bin:\/usr\/bin:\/usr\/local\/bin:\/opt\/chef\/embedded\/bin/ }
  end
  describe file('/etc/cron.d/archive_encrypted') do
    it { should be_file }
  end
  describe file('/etc/cron.d/archive') do
    it { should be_file }
  end
  describe file('/etc/cron.d/no_split_test') do
    it { should be_file }
  end
    # this helps prove our tests tried to dump data
  directory file('/tmp/archive') do
    it { should be_directory }
  end
  directory file('/tmp/archive_encrypted') do
    it { should be_directory }
  end
  describe file('/tmp/no_split_test') do
    it { should be_directory }
  end
  describe file('/tmp/archive_attribute_test') do
    it { should be_directory }
  end
end
control 'it should have a models configured accordingly' do
  describe file('/opt/backup/models/no_split_test.rb') do
    it { should be_file }
    its(:content) { should_not match /notify_by/ }
    its(:content) { should_not match /split_into_chunks_of/ }
  end
  describe file('/opt/backup/models/archive_encrypted.rb') do
    it { should be_file }
    its(:content) { should match /encrypt_with OpenSSL/ }
    its(:content) { should_not match /MAILTO/ }
    its(:content) { should_not match /notify_by/ }
  end
  describe file('/opt/backup/models/archive_attribute_test.rb') do
    it { should be_file }
    its(:content) { should match /notify_by/ }
  end
end
