module GStore
  class Client
    
    def list_buckets(options={})
      get(nil, '/', options)
    end
    
    def create_bucket(bucket, options={})
      put(bucket, '/', options)
    end
    
    def get_bucket(bucket, options={})
      get(bucket, '/', options)
    end
    
    def delete_bucket(bucket, options={})
      delete(bucket, '/', options)
    end
    
  end

  class GSBucket

    attr_accessor :name, :acl_list

    def initialize(name)
      @name=name
    end

    def self.getBuckets
      GSBucketList.new.get
    end

    def get(options={})
      @acl_list = []
      response = GStore.client.get_bucket(name,options)
      doc = Nokogiri::XML(response)
      doc.xpath("//Entry").each do |entry|
        acl = {}
        acl[:acl_type] = entry.xpath("Scope")[0]["type"]
        acl[:acl_permission] = entry.xpath("Permission")[0].text
        @acl_list << acl
      end
      @acl_list
    end

    def put(acl_policy=nil)
      if acl_policy
        GStore.client.create_bucket @name , :headers => {'x-goog-acl'=> acl_policy}
      else
        GStore.client.create_bucket @name
      end

    end

    def delete
        GStore.client.delete_bucket name
    end

    def ==(bucket)
      return @name == bucket.name
    end
  end

  class GSBucketList

    #fetch all the Buckets belongs to this user
    def get(options={})
      buckets = []
      response = GStore.client.list_buckets(options)
      doc = Nokogiri::XML(response)

      doc.xpath("//xmlns:Name").each do |node|
        buckets << GSBucket.new(node.text)
      end

      buckets
    end
  end

end
