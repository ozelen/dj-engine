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
S3_KEY = ENV['AWS_KEY_ID']
S3_SEC = ENV['AWS_KEY_SECRET']

CarrierWave.configure do |config|
  config.fog_credentials = {
      persistent: false,
      provider: "AWS",
      region: 'eu-west-1',
      aws_access_key_id: S3_KEY,
      aws_secret_access_key: S3_SEC,
  }
  config.fog_directory = Rails.env.production? ? 'bh-prod' : 'bh-dev' #S3_CONFIG['bucket']
  #config.fog_public     = true
  #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end