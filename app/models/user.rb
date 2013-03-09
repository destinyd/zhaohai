class User
  include Mongoid::Document
  rolify
  include Mongoid::Timestamps

  has_many :activities,class_name: 'Activity', :inverse_of => :user

  has_and_belongs_to_many :in_activities,class_name: 'Activity',inverse_of: :users

  has_and_belongs_to_many :invited_activities,class_name: 'Activity',inverse_of: :invited_users, autosave: true
  has_and_belongs_to_many :interested_activities,class_name: 'Activity',inverse_of: :interested_users

  has_many :comments
  has_many :commenteds,class_name: 'Comment',as: :commentable

  has_and_belongs_to_many :following,class_name: 'User',inverse_of: :followers
  has_and_belongs_to_many :followers,class_name: 'User',inverse_of: :following

  has_many :activity_requests

  #embeds_one :userinfo#,autobuild: true
  has_one :userinfo#,autobuild: true
  accepts_nested_attributes_for :userinfo

  embeds_many :notifications, :class_name => 'Notification::Base'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email
  validates_presence_of :encrypted_password
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })
  field :name, :type => String
  #field :avatar,    :type => String
  mount_uploader :avatar, AvatarUploader
  validates :name,presence: true, uniqueness: true, length: {in: 2..16}
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me,:userinfo_attributes,:avatar, :avatar_cache

  scope :index,only(:name,:avatar).includes(:userinfo)

  def to_s
    name
  end

  def follow!(user)
    if self.id != user.id && !self.following.include?(user)
      self.following << user
      user.notifications.create!({
        follower: self
      },
        Notification::Follower)
    end
  end

  def unfollow!(user)
    self.following.delete(user)
  end

  def friend
    following & followers
  end

  def quit_activity(activity_id)
    begin
      activity = in_activities.find(activity_id)
      activity.users.delete(self) unless activity.user == self
      activity
    rescue
    end
  end

  def as_json(options={})
    options[:only] = [:_id,:name,:avatar] if options.blank?
    super(options)
  end

  def self.create_phone_test
    u = User.new(name: random_phone_name,email: random_email)
    u.userinfo = Userinfo.new gender: :female
    u.save(:validate =>false)
    u
  end

  def self.random_phone_name
    rand_name = random_name
    User.where(name: rand_name).any? ? random_phone_name : rand_name
  end

  def self.random_string
    o =  ('0'..'9').to_a
    (0...12).map{ o[rand(o.length)] }.join
  end

  def self.random_name
    I18n.t('random.phone') + random_string
  end

  def self.random_email
    rand_email = "#{random_string}@zhaohigh.com"
    User.where(email: rand_email).any? ?  random_email : rand_email 
  end

end
