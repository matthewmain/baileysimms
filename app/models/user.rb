# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  user_name          :string
#  email              :string
#  password           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  password_digest    :string
#  remember_digest    :string
#  admin              :boolean          default(FALSE)
#  activation_digest  :string
#  activated          :boolean          default(FALSE)
#  activated_at       :datetime
#  reset_digest       :string
#  reset_sent_at      :datetime
#  vip                :boolean          default(FALSE)
#  share_count        :integer          default(0)
#  oauth_provider     :string
#  oauth_token        :string
#  oauth_expires_at   :datetime
#  facebook_id        :string
#  facebook_name      :string
#  facebook_image     :string
#  has_shared_website :boolean          default(FALSE)
#  can_access_AU_1    :boolean          default(FALSE)
#  can_access_part_2  :boolean          default(FALSE)
#  can_access_part_3  :boolean          default(FALSE)
#  can_access_part_4  :boolean          default(FALSE)
#  can_access_part_5  :boolean          default(FALSE)
#  can_access_part_6  :boolean          default(FALSE)
#  can_access_part_7  :boolean          default(FALSE)
#  can_access_part_8  :boolean          default(FALSE)
#  can_access_part_9  :boolean          default(FALSE)
#  can_access_part_10 :boolean          default(FALSE)
#  can_access_part_11 :boolean          default(FALSE)
#  can_access_part_12 :boolean          default(FALSE)
#  can_access_part_13 :boolean          default(FALSE)
#  can_access_part_14 :boolean          default(FALSE)
#  share_record       :text
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_many :replies, dependent: :destroy

	default_scope -> { order(activated_at: :desc) }			

	attr_accessor :remember_token, :activation_token, :reset_token

	validates :user_name, presence: true, 
												length:	{ maximum: 20 },
												format: { with: /\A[a-zA-Z0-9_ ]+\z/,
																	message: "must include only letters, numbers, or spaces" },
												uniqueness: { case_sensitive: false } 					

	before_save :downcase_email
	before_create :create_activation_digest
	validates :email, presence: true, 
										length: { maximum: 255 },
										format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, 
															message: "must be a valid email address" },
										uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, presence: true, length: { minimum: 3 }, allow_nil: true

	serialize :share_record, Array
	

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



  ### FACEBOOK OMNIAUTH & KOALA ###

	def self.from_omniauth(auth,current_user)
	  current_user.tap do |user| 
	    user.oauth_provider = auth.provider
	    user.oauth_token = auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.facebook_id = auth.uid
	    user.facebook_name = auth.info.name
	    user.facebook_image = auth.info.image
	    user.save!
	  end
	end

	def is_connected_to_facebook
		self.oauth_token?
	end

	def disconnect_from_facebook
		self.oauth_provider = nil
    self.oauth_token = nil
    self.oauth_expires_at = nil
		self.save!
	end

	def facebook
		@facebook ||= Koala::Facebook::API.new(oauth_token)
	end



	### SHARES AND UNLOCKS ###

	def has_unlocked_part?(partnumber)
		if partnumber < 1 || partnumber > 14
			false
		else
			partnumber == 1 ? self.can_access_AU_1 : self.send("can_access_part_#{partnumber}")
		end
	end

	def can_access_post?(post_id)
		if !Post.exists?(post_id) 
			false
		elsif post_id == 1
			true
		else
			part_number = Post.find(post_id).book_part
			self.has_unlocked_part?(part_number)
		end
	end

	def reset_share_history
		self.share_count = 0
		self.has_shared_website = false
		self.can_access_AU_1 = false
		(2..14).each {|n| self.send("can_access_part_#{n}=", false) }
		self.share_record = []
		self.save!
	end

	def self.all_activated_users_unlock_part(partnum)
		@all_activated_users = User.where("activated = ?", true)
		@all_activated_users.each {|user| user.update_attribute(:can_access_AU_1, true)} if partnum == 1
		@all_activated_users.each {|user| user.send("can_access_part_#{partnum}=", true); user.save!} if partnum > 1
	end

	def self.total_shares
		User.all.inject(0) {|sum, user| sum += user.share_count}
	end



	### QUERIES ###

	def self.all_activated_user_names
		self.all.map { |user| user[:user_name] if user.activated? }.compact
	end

	def self.all_activated_emails_as_array
		self.all.map { |user| user[:email] if user.activated? }.compact
	end

	def self.all_activated_emails_as_string
		self.all_activated_emails_as_array.join(', ')
	end


	#Comment/Word Count, All-Time

	def comment_count
		self.comments.count
	end

	def all_comments_word_count
		self.comments.pluck("content").join(' ').gsub(/\r\n/,' ').count(' ')+1 if self.comment_count > 0
	end

	def reply_count
		self.replies.count
	end


	#Share/Comment/Word Count, By Month

	def share_count_by_month(month)
		self.share_record.count {|share| share[:date].strftime("%-m") == month.to_s }
	end

	def comment_count_by_month(month)
		if Rails.env.development?
			#SQLite database queries (local development environment) need to use 'strftime()' to grab info from datetimes
			self.comments.where("strftime('%m', created_at)+0 = ?", month).count + self.replies.where("strftime('%m', created_at)+0 = ?", month).count
		elsif Rails.env.production?
			#Postgres database queries (remote Heroku production enviroment) need to use 'extract' to grab info from datetimes
			self.comments.where('extract(month from created_at) = ?', month).count + self.replies.where('extract(month from created_at) = ?', month).count
		end
	end

	def comments_word_count_by_month(month)
		self.comments.pluck("content").join(' ').gsub(/\r\n/,' ').count(' ')+1 if self.comment_count_by_month(month) > 0
	end	


	#Hashes of User Names and Their Comment Counts, All

	def self.all_user_names_with_comment_count
		User.all.each_with_object({}) {|user,hash| hash[user.user_name] = user.comment_count}
	end

	def self.all_user_names_by_comment_count
		User.all_user_names_with_comment_count.sort_by {|key,value| -value }.to_h
	end		


	#Hashes of Non-Admin User Names and Their Comment Counts, All

	def self.all_non_admin_users
		User.where("admin = ?", false)
	end

	def self.all_non_admin_user_names_with_comment_count
		User.all_non_admin_users.each_with_object({}) {|user, hash| hash[user.user_name] = user.comment_count + user.reply_count }
	end

	def self.all_non_admin_user_names_by_comment_count
		User.all_non_admin_user_names_with_comment_count.sort_by {|user, comment_count| comment_count }.reverse.to_h
	end

	def self.top_non_admin_users_by_comment_count(limit)
		User.all_non_admin_user_names_with_comment_count.sort_by do |user, comment_count| 
			[-(comment_count), -(User.find_by_user_name(user).all_comments_word_count.to_i)]
		end[0..(limit-1)].to_h
	end	


	#Hashes of Non-Admin User Names and Their Comment Counts, By Month

	def self.all_non_admin_user_names_with_comment_count_by_month(month)
		User.all_non_admin_users.each_with_object({}) {|user, hash| hash[user.user_name] = user.comment_count_by_month(month)}
	end

	def self.all_non_admin_user_names_by_comment_count_by_month(month)
		User.all_non_admin_user_names_with_comment_count_by_month(month).sort_by {|user, comment_count| comment_count }.reverse.to_h
	end

	def self.top_non_admin_users_by_comment_count_by_month(month,limit)
		User.all_non_admin_user_names_with_comment_count_by_month(month).sort_by do |user, comment_count| 
			[-(comment_count), -(User.find_by_user_name(user).comments_word_count_by_month(month).to_i)]
		end[0..(limit-1)].to_h
	end


	#Hashes of Non-Admin Users With Share Counts and Comment Counts, All

	def self.all_non_admin_users_with_share_and_comment_counts
		User.all_non_admin_users.each_with_object({}) {|user, hash| hash[user.user_name] = {shares: user.share_count, comments: user.comment_count + user.reply_count} }
	end

	def self.top_non_admin_users_by_share_then_comment_counts(limit)
		User.all_non_admin_users_with_share_and_comment_counts.sort_by do |user, participation| 
			[-(participation[:shares]), -(participation[:comments])]
		end[0..(limit-1)].to_h
	end	


	#Hashes of Non-Admin Users With Share Counts and Comment Counts, By Month

	def self.all_non_admin_users_with_share_and_comment_counts_by_month(month)
		User.all_non_admin_users.each_with_object({}) {|user, hash| hash[user.user_name] = {shares: user.share_count_by_month(month), comments: user.comment_count_by_month(month)} }
	end

	def self.top_non_admin_users_by_share_then_comment_counts_by_month(month,limit)
		User.all_non_admin_users_with_share_and_comment_counts_by_month(month).sort_by do |user, participation| 
			[-(participation[:shares]), -(participation[:comments])]
		end[0..(limit-1)].to_h
	end


	#Facebook shares

	def self.facebook_share_count
		User.all.inject(0) {|sum,user| sum + user.share_count.to_i}
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

