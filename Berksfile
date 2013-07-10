site :opscode

metadata

cookbook "build-essential"

group :integration do
  cookbook "apt"
  cookbook "yum"
  cookbook "minitest-handler"
  cookbook "backup_test", path: "test/cookbooks/backup_test"
end