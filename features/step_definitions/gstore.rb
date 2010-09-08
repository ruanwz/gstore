When /^the bucket name according the current time$/ do
  @bucket=Time.now.hash.abs
end

When /^I create the bucket$/ do
  @client=GStore::Client.new :access_key => $google_storage_api_access_key, :secret_key => $google_storage_api_secret_key
  @client.create_bucket @bucket
end

Then /^I can list the bucket$/ do
  response= @client.list_buckets
  puts response
  doc = XmlSimple.xml_in(response)
  p doc
end


