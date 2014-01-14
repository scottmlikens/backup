## v0.0.9:

* Remove rescue blocks around `use_inline_resources` and test for its existiance.
+ added a test suite to verify the cookbook works still with chef10


## v0.0.8:

* Backup on minute 0.  `*` would backup every minute at 1am
* Enable `s3_options` which allows you to specify th S3 endpoint

```ruby
store_with({"engine" => "S3", "settings" => { "s3.access_key_id" => "S3_ACCESS_KEY", "s3.secret_access_key" => "S3_SECRET_ACCESS_KEY", "s3.bucket" => "BUCKET", "s3.path" => "DIR", "s3.keep" => 5, "s3.fog_options" => {  :host => 's3.DUMMY.DOMAIN.COM', :scheme => 'http', :port => 80 } } } )
  action :backup
```  

- Removed blind rescue

## v0.0.7:

* Added whyrun support


## v0.0.6:

* Add Additional attributes for logging; cron path and where the gem binary is located.
* Add Debian box to test-kitchen
* Always manage cron instead of on just when creating the model

## v0.0.5:

* Improve README
* Add Minitests 
* Use Inline Resources

## v.0.04:

* Convert to LWRP

## v.0.0.3:

Fork from Heavywater
