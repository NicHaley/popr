CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJV5KOGGZKK56FXAQ',                        # required
    :aws_secret_access_key  => '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',                        # required
    :region                 => 'us-west-2',                  # optional, defaults to 'us-east-1'
    # :host                   => 's3.example.com',             # optional, defaults to nil
    # :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory  = 'bitmaker-popr'                          # required
  # config.fog_public     = false                                        # optional, defaults to true
  # config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
end