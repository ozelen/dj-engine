S3_CONFIG = YAML.load_file("#{::Rails.root}/config/s3.yml")[::Rails.env]
CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: 'AKIAJD553Y7CKLHWQTFA', # S3_CONFIG['key'],
      aws_secret_access_key: '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' # S3_CONFIG['secret']
  }
  config.fog_directory = 'djerelo' #S3_CONFIG['bucket']
end