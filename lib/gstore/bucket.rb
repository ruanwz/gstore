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

    attr_accessor :name

    def initialize(name)
      @name=name
    end

    def self.getBuckets
      GSBucketList.new.get
    end

    def get(options={})

    end

    def put(acl_policy=nil)
      if acl_policy
        GStore.client.create_bucket @name , :headers => {'x-google-acl'=> acl_policy}
      else
        GStore.client.create_bucket @name
      end

    end

    def delete
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
