require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 'e740e7098815ce21d64a1e238b891b89', 'ddd5b1dd54b2eb99fb9b79835d1a0fc8'
end
