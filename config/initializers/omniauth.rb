require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'TlNLKBftYEPmU1mlkcRqrg', 'Bf4hXnIm3Wrv7pZML6vgFappUcqLQSpatG0hMryJDfk'
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end
