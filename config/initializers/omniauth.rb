OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], 		# ENV variables set using Figaro gem in config/application.yml 
  				 :image_size => 'large'  																			
end