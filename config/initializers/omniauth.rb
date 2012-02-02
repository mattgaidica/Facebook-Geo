Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == "production"
    provider :facebook, '103826493075115', '0441da7154ffe57f61124e3d27d4d8a9'
  else
    provider :facebook, '103230106469740', '07d0543dce1859249f74d08b7649dd30'
  end
end