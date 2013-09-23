S3_CONFIG = YAML.load_file("#{::Rails.root}/config/s3.yml")[::Rails.env]
CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: S3_CONFIG['key'],
      aws_secret_access_key: S3_CONFIG['secret']
  }
  config.fog_directory = S3_CONFIG['bucket']
end