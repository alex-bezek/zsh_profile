#!/usr/bin/env ruby

environment = ARGV[0]
system_account_key = ''
system_account_secret = ''
system_account_url = ''

case environment.downcase
when 'stage'
  system_account_key=`/usr/local/bin/lpass show --username PROXIMA_STAGING_SYSTEM_ACCOUNT`.strip
  system_account_secret=`/usr/local/bin/lpass show --password PROXIMA_STAGING_SYSTEM_ACCOUNT`.strip
  system_account_url = 'https://api.sandboxcernercare.com/oauth/access'
when 'prod'
  system_account_key=`/usr/local/bin/lpass show --username TECHOPS_PROD_SYSTEM_ACCOUNT`.strip
  system_account_secret=`/usr/local/bin/lpass show --password TECHOPS_PROD_SYSTEM_ACCOUNT`.strip
  system_account_url = 'https://api.cernercare.com/oauth/access'
end

if(system_account_key && system_account_secret && system_account_url)
  token = `java -jar ~/Downloads/auth-header-1.4.jar -k #{system_account_key} -s #{system_account_secret} -p #{system_account_url}`.strip
else
  token = "[ERROR] Requested environment #{environment.upcase} not configured"
end

print token
