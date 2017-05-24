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
end
