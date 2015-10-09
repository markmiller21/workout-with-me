Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1008625599180843', 'ff8dbae805565b26599d7c4f41a4e7d6'
end