Backup::Model.new(:daily, 'Daily backups for MySQL, Redis and MongoDB') do
  split_into_chunks_of 250
  database MySQL
  database MongoDB
  database Redis
  store_with S3
  compress_with Gzip
  encrypt_with GPG
end
