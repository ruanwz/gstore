Given /^the bucket name according the current time$/ do
  @bucket_name=Time.now.hash.abs.to_s + '_bucket'
end

Given /^the object name according the current time$/ do
  @object_name=Time.now.hash.abs.to_s + '_object'
  @object_conttent="test"
end

When /^I create the bucket$/ do
  @client=GStore::Client.new :access_key => $google_storage_api_access_key, :secret_key => $google_storage_api_secret_key
  @client.instance_variable_set "@debug", true
  @client.create_bucket @bucket_name
end

When /^I create the bucket with public acl$/ do
  @client=GStore::Client.new :access_key => $google_storage_api_access_key, :secret_key => $google_storage_api_secret_key
  @client.instance_variable_set "@debug", true
  @client.create_bucket @bucket_name, :headers => {'x-goog-acl' => 'public-read'}
end


Then /^I can list the bucket$/ do
  response= @client.list_buckets
  nokogiri_doc = Nokogiri::XML(response)
  @bucket_name_list=[]
  nokogiri_doc.xpath("//xmlns:Name").each do |node|
    @bucket_name_list << node.text
  end

  #p doc
  #"<?xml version='1.0' encoding='UTF-8'?><ListAllMyBucketsResult xmlns='http://doc.s3.amazonaws.com/2006-03-01'><Owner><ID>00b4903a97160e20eb0c026e252d8f0830b8fa82d7b34a9b0d41f386096aac0b</ID><DisplayName>David Ruan</DisplayName></Owner><Buckets><Bucket><Name>862187732_bucket</Name><CreationDate>2010-09-15T06:36:36.428Z</CreationDate></Bucket><Bucket><Name>862650248_bucket</Name><CreationDate>2010-09-15T06:34:43.869Z</CreationDate></Bucket><Bucket><Name>862872469_bucket</Name><CreationDate>2010-09-15T06:34:48.713Z</CreationDate></Bucket><Bucket><Name>rmu</Name><CreationDate>2010-07-11T00:51:14.917Z</CreationDate></Bucket><Bucket><Name>ruanwz</Name><CreationDate>2010-07-10T19:20:21.412Z</CreationDate></Bucket><Bucket><Name>ruanwz_share</Name><CreationDate>2010-07-11T00:54:55.670Z</CreationDate></Bucket></Buckets></ListAllMyBucketsResult>"
end

Then /^the list include the bucket$/ do
  @bucket_name_list.should include @bucket_name
end

When /^I delete the bucket$/ do
  @client.delete_bucket @bucket_name
end
When /^I delete the object$/ do
  @client.delete_object @bucket_name, @object_name
end


Then /^the list doesn't include the bucket$/ do
  @bucket_name_list.should_not include @bucket_name
end

When /^I get the public acl of bucket$/ do
#<?xml version='1.0' encoding='UTF-8'?><AccessControlList><Owner><ID>00b4903a97160e20eb0c026e252d8f0830b8fa82d7b34a9b0d41f386096aac0b</ID><Name>David Ruan</Name></Owner><Entries><Entry><Scope type='UserById'><ID>00b4903a97160e20eb0c026e252d8f0830b8fa82d7b34a9b0d41f386096aac0b</ID><Name>David Ruan</Name></Scope><Permission>FULL_CONTROL</Permission></Entry><Entry><Scope type='AllUsers'/><Permission>READ</Permission></Entry></Entries></AccessControlList>
  response = @client.get_bucket @bucket_name, :params=> {:acl => true}
  doc = Nokogiri::XML(response)
  doc.xpath("//Entry//Scope")[1]["type"].should == "AllUsers"
  doc.xpath("//Entry//Permission")[1].text.should == "READ" 
end


When /^I put the object$/ do
  @client.put_object @bucket_name, @object_name, :data => @object_conttent
end

Then /^I can get the object$/ do
  @client.get_object(@bucket_name, @object_name).should == @object_conttent
end


Given /^the access info$/ do
  @bucket_list=GStore::GSBucketList.new :access_key => $google_storage_api_access_key, :secret_key => $google_storage_api_secret_key
end

Then /^I can list the bucket list$/ do
  puts @bucket_list.get
end
