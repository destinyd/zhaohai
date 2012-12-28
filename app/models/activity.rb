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

  field :title, type: String, :default => ""
  field :desc, type: String
  field :address, type: String
  validates_presence_of :title
  field :lat, type: Float
  field :lng, type: Float
  validates_presence_of :lat
  validates_presence_of :lng
  #field :user_id, type: Integer
  field :started_at, type: DateTime
  field :finished_at, type: DateTime

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

  scope :opening,where(:finished_at.gt => Time.now)
  scope :running,opening.where(:started_at.lt =>  Time.now)
  scope :expired,where(:finished_at.lt =>  Time.now)

  def to_s
    title
  end

  def user_name
    user.try(:name)
  end

  def admin
    user
  end

  def interested(u)
    interested_users << u unless interested_users.include?(u)
  end

  def accept(own,user)
    if own == admin and is_open?
      if interested_users.include? user
        interested_users.delete user
        self.users << user
        true
      end
    end
  end

  def finish(own)
    update_attribute :finished_at,DateTime.now if own == admin and is_open?
  end

  def is_open?
    t = DateTime.now
    t > started_at and t < finished_at
  end

  protected

  before_create do
    self.finished_at = started_at + 4.hours
  end

  after_create do
    self.users << user
  end


end
