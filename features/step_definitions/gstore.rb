When /^the bucket name according the current time$/ do
  @bucket_name=Time.now.hash.abs.to_s
end

When /^I create the bucket$/ do
  @client=GStore::Client.new :access_key => $google_storage_api_access_key, :secret_key => $google_storage_api_secret_key
  @client.create_bucket @bucket_name
end

Then /^I can list the bucket$/ do
  response= @client.list_buckets
  doc = XmlSimple.xml_in(response)
  @bucket_name_list=[]
  doc["Buckets"][0]["Bucket"].each do |b|
    @bucket_name_list << b["Name"][0]
  end
end

Then /^the list include the bucket$/ do
  @bucket_name_list.should include @bucket_name
end

When /^I delete the bucket$/ do
  @client.delete_bucket @bucket_name
end

Then /^the list doesn't include the bucket$/ do
  @bucket_name_list.should_not include @bucket_name
end

When /^I change the acl of the bucket$/ do
    pending # express the regexp above with the code you wish you had
end

When /^I get the acl of the bucket$/ do
    pending # express the regexp above with the code you wish you had
end

Then /^the acl of bucket is changed$/ do
    pending # express the regexp above with the code you wish you had
end



