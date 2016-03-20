OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], :authorize_params => { :display => 'popup' }  # ENV variables set using Figaro gem in config/application.yml
end