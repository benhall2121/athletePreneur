require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'TlNLKBftYEPmU1mlkcRqrg', 'Bf4hXnIm3Wrv7pZML6vgFappUcqLQSpatG0hMryJDfk'
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  #			App ID/API Key		App Secret
  provider :facebook, "115233855251733", "edbe8a988ad7d3e9c6587e0f1c23363a", {:scope => 'publish_stream,offline_access,email', :client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
end
