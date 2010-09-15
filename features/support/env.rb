$: << File.join(File.dirname(__FILE__), "/../../lib" )
require 'rubygems'
require 'nokogiri'
require 'gstore'

config = File.exists?("#{ENV['HOME']}/.gstore") ? YAML::load(open("#{ENV['HOME']}/.gstore")) : Hash.new
if config.empty?
  print "> what was the access key google storage api provided you with? "
  config['access_key'] = STDIN.gets.chomp
  print "> what was the secret key google storage api provided you with? "
  config['secret_key'] = STDIN.gets.chomp
  File.open( "#{ENV['HOME']}/.gstore", 'w' ) do |out|
     YAML.dump( config, out )
  end

end
$google_storage_api_access_key=config['access_key']
$google_storage_api_secret_key=config['secret_key']

if __FILE__ == $0
   @bucket_name=Time.now.hash.abs.to_s + '_bucket'
   @client=GStore::Client.new :access_key => $google_storage_api_access_key, :secret_key => $google_storage_api_secret_key
   @client.instance_variable_set "@debug", true
   @client.create_bucket @bucket_name, :headers => {'x-goog-acl' => 'public-read'}
   response = @client.get_bucket @bucket_name, :params=> {:acl => true}
end
