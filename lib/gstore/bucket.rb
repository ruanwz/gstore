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
    def self.getBuckets
    end
    def get(options={})
    end
    def put(acl_policy=nil)
    end
    def delete
    end
  end

  class GSBucketList
    #fetch all the Buckets belongs to this user
    def get
    end
  end
end
