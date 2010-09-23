module GStore
  class Client
    def put_object(bucket, filename, options={})
      put(bucket, "/#{filename}", options)
    end
    
    def get_object(bucket, filename, options={})
      outfile = options.delete(:outfile)
      res = get(bucket, "/#{filename}", options)
      if outfile
        File.open(outfile, 'w') {|f| f.write(res) }
      else
        res
      end
    end
    
    def delete_object(bucket, filename, options={})
      delete(bucket, "/#{filename}", options)
    end
    
    def get_object_metadata(bucket, filename, options={})
      head(bucket, "/#{filename}", options)
    end
  end

  class GSObject

    attr_reader :bucket
    attr_accessor :name
    attr_writer :metadata, :value
    
    def initialize(bucket, name, value=nil, metadata=nil)
      @bucket, @name, @value, @metadata = bucket, name, value, metadata
    end

    def value
      GStore.client.get_object(bucket.name,@name)
    end

    def put(acl_polic=nil)
      options = {:data => @value}
      GStore.client.put_object(@bucket.name,@name,options)
    end

    def metadata
    end

    def delete(options={})
      GStore.client.delete_object(@bucket.name,@name,options)
    end

    def ==(object)
      return (bucket.name == object.bucket.name) && (name == object.name)
    end
  end
    
end
