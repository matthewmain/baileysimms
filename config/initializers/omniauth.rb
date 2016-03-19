OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "1115188781859441", "3beb313ac314db24979b0f4a599249f0"  # strings are "Facebook App Id", "Facebook Secret", respectively
end