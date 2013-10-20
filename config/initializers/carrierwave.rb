module CarrierWave
  module Storage
    class Fog
      class File
        alias :store_without_safety_net :store
        def store(new_file)
          retries_remaining = 3
          begin
            store_without_safety_net(new_file)
          rescue Excon::Errors::SocketError => e
            if e.inspect =~ /Connection reset by peer/
              retries_remaining -= 1
              if retries_remaining <= 0
                raise
              else
                retry
              end
            else
              raise
            end
          end
        end
      end
    end
  end
end

S3_CONFIG = YAML.load_file("#{::Rails.root}/config/s3.yml")[::Rails.env]
CarrierWave.configure do |config|
  config.fog_credentials = {
      persistent: false,
      provider: "AWS",
      region: 'eu-west-1',
      aws_access_key_id: 'AKIAJD553Y7CKLHWQTFA', # S3_CONFIG['key'],
      aws_secret_access_key: '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' # S3_CONFIG['secret'],
  }
  config.fog_directory = 'djerelo-storage' #S3_CONFIG['bucket']
  #config.fog_public     = true
  #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end