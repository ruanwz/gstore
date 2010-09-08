$: << File.join(File.dirname(__FILE__), "/../../lib" )
require 'rubygems'
require 'xmlsimple'
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

