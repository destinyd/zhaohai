class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::TaggableOn

  belongs_to :user, :inverse_of => :activities#,class_name: 'User'

  has_and_belongs_to_many :users,class_name: 'User' ,inverse_of: :in_activities

  has_and_belongs_to_many :invited_users,class_name: 'User',inverse_of: :invited_activities

  has_and_belongs_to_many :interested_users,class_name: 'User',inverse_of: :interested_activities

  has_many :commenteds,class_name: 'Comment',as: :commentable

  has_many :activity_requests

  field :title, type: String, :default => ""
  field :desc, type: String
  field :address, type: String
  validates_presence_of :title
  field :lat, type: Float
  field :lng, type: Float
  validates_presence_of :lat
  validates_presence_of :lng
  #field :user_id, type: Integer
  field :started_at, type: DateTime,default: ->{ Time.now }
  field :finished_at, type: DateTime
  field :closed_at, type: DateTime

  taggable_on :types

  index({
    :title => 1,
  },
  { background: true})

  index({
    :started_at => 1
  },
  { background: true})

  index({
    :finished_at => 1
  },
  { background: true})

  attr_accessible :title, :desc, :lat, :lng, :started_at,:address,:type_list#, :finished_at

  scope :opening,where(:finished_at.gt => Time.now,:closed_at => nil)
  scope :running,opening.where(:started_at.lt =>  Time.now)
  scope :expired,where(:finished_at.lt =>  Time.now)
  scope :recent,order_by(created_at: :desc)
  scope :not_me,lambda{|me|me ? excludes(user_id: me.id ) : scoped }
  scope :city_with,lambda{|city| where(address: Regexp.new(city) )}
  scope :points,lambda{|city| opening.city_with(city).only(:title,:lat,:lng) }
  scope :index,opening.recent

  def to_s
    title
  end

  def user_name
    user.try(:name)
  end

  def admin
    user
  end

  def admins
    [user]
  end

  def could_join?(user)
    [:opening,:running].include?(self.status) and 
    (user.nil? or 
     (!could_manage?(user) and !users.include?(user) and !interested_users.include?(user))
    )

  end

  def could_manage?(user)
    [:opening,:running].include?(self.status) and (!user or admins.include?(user))
  end

  def interested(u)
    unless interested_users.include?(u)
      interested_users << u
    end
  end

  def accept(user)
    if is_open? and interested_users.include? user
      interested_users.delete user
      self.users << user
      true
    end
  end

  def invite(str_ids)
    ids = str_ids.split(',') unless str_ids.blank?
    if could_manage?(nil) and !ids.blank?
      invite_users = User.find(ids)
      self.invited_users << invite_users
      self.invited_user_ids.compact!
      self.invited_user_ids.uniq!
      save
      invite_users.each do |iu|
        iu.notifications.create!({
          invite_user: self.user,
          activity: self},
          Notification::Invited)
      end

    end
  end

  def finish(own)
    update_attribute :finished_at,DateTime.now if own == admin and is_open?
  end

  def is_open?
    t = DateTime.now
    t < finished_at
  end

  def is_run?
    t = DateTime.now
    is_open? and t > started_at
  end

  def is_closed?
    !closed_at.nil?
  end

  def close
    update_attribute :closed_at,Time.now if closed_at.nil?
  end

  def status
    if is_closed?
      :closed
    else
      is_open? ? is_run? ? :running : :opening : :expired
    end
  end

  def human_status
    I18n.t("activity_status."+ status.to_s)
  end

  def self_managed
    false
  end
  
  def as_json(options={})
    options[:except] = [:user_ids,:user_id,:invited_user_ids,:interested_user_ids] if options.blank?
    super(options)
  end

  protected

  before_create do
    self.finished_at = started_at + 4.hours
  end

  after_create do
    self.users << user
  end


end
