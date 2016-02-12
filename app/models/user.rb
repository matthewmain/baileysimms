# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  user_name         :string
#  email             :string
#  password          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  password_digest   :string
#  remember_digest   :string
#  admin             :boolean          default(FALSE)
#  activation_digest :string
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  reset_digest      :string
#  reset_sent_at     :datetime
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ActiveRecord::Base
	has_many :comments

	attr_accessor :remember_token, :activation_token, :reset_token

	validates :user_name, presence: true, 
												length:	{ maximum: 20 },
												format: { with: /\A[a-zA-Z0-9_]+\z/,
																	message: "must include only letters, numbers, or underscores (no spaces)" } 					

	before_save :downcase_email
	before_create :create_activation_digest
	validates :email, presence: true, 
										length: { maximum: 255 },
										format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, 
															message: "must be a valid email address" },
										uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, presence: true, length: { minimum: 3 }, allow_nil: true
	

	#changes User's 'to_param' method's default from 'id' to 'user_name', which re-routes default 'user/:id' URLS to 'user/:user_name'
  def to_param
    user_name
  end


	### COOKIES ### 

	#returns the hash digest of the given string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	#returns a random token of 22 characters (of: A-Z, a-z, 0-9, -, _)
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	#remembers a user in the database for use in persistent sessions
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	#returns true if the given token matches the digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

	#forgets a user
	def forget
		update_attribute(:remember_digest, nil)
	end



	### ACOUNT ACTIVATION ###

	#activates an account
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  #sends an activation email
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end



  ### PASSWORD RESET ###

  #sets the password reset attributes
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  #sends password reset email
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  #returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end


	### QUERIES ###

	def self.all_user_names
		User.all.map { |user| user[:user_name] }
	end



	private

		def downcase_email
			self.email = email.downcase
		end

		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(activation_token)
		end

end

