Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == "production"
    #provider :facebook, '222312241193666', '24b31ac6bd0fb524d012536242eacd45'
  else
    provider :facebook, '103230106469740', '07d0543dce1859249f74d08b7649dd30'
  end
end