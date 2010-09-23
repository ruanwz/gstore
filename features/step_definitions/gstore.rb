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
  doc = XmlSimple.xml_in(response)
  #p doc
#{"Buckets"=>[{"Bucket"=>[{"CreationDate"=>["2010-09-08T14:55:04.806Z"], "Name"=>["862997178"]}, {"CreationDate"=>["2010-09-08T14:49:32.891Z"], "Name"=>["863030468"]}, {"CreationDate"=>["2010-09-08T14:52:47.200Z"], "Name"=>["863332240"]}, {"CreationDate"=>["2010-07-11T00:51:14.917Z"], "Name"=>["rmu"]}, {"CreationDate"=>["2010-07-10T19:20:21.412Z"], "Name"=>["ruanwz"]}, {"CreationDate"=>["2010-07-11T00:54:55.670Z"], "Name"=>["ruanwz_share"]}]}], "Owner"=>[{"DisplayName"=>["David Ruan"], "ID"=>["00b4903a97160e20eb0c026e252d8f0830b8fa82d7b34a9b0d41f386096aac0b"]}], "xmlns"=>"http://doc.s3.amazonaws.com/2006-03-01"}

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
When /^I delete the object$/ do
  @client.delete_object @bucket_name, @object_name
end


Then /^the list doesn't include the bucket$/ do
  @bucket_name_list.should_not include @bucket_name
end

When /^I get the public acl of bucket$/ do
    response = @client.get_bucket @bucket_name, :params=> {:acl => true}
    doc = XmlSimple.xml_in(response)
    permission_list = []
    doc["Entries"][0]["Entry"].each do |d|
      permission_list << [d['Permission'][0], d['Scope'][0]]
    end
    permission_list.should include ["READ",{"type"=>"AllUsers"}]
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
