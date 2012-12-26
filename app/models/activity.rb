class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :holder,class_name: 'User', :inverse_of => :hold_activities
  has_and_belongs_to_many :users,inverse_of: :activities

  has_and_belongs_to_many :invited_users,class_name: 'User',inverse_of: :invited_activities

  has_and_belongs_to_many :interested_users,class_name: 'User',inverse_of: :interested_activities

  has_many :commenteds,class_name: 'Comment',as: :commentable

  field :title, type: String, :default => ""
  field :desc, type: String
  validates_presence_of :title
  field :lat, type: Float
  field :lng, type: Float
  validates_presence_of :lat
  validates_presence_of :lng
  #field :user_id, type: Integer
  field :started_at, type: Time
  validates_presence_of :started_at
  field :finished_at, type: Time
  belongs_to :user

  index({
    :title => 1,
    :user_id => 1,
    :lat => 1,
    :lng => 1
  },
  { :unique => true})

  attr_accessible :title, :desc, :lat, :lng, :started_at#, :finished_at

  scope :opening,where("finished_at > NOW()")
  scope :running,opening.where("started_at <  NOW()")

  before_create do
    self.finished_at = started_at + 4.hours
  end

  after_create do
    self.users << holder
  end

  def user_name
    holder.try(:name)
  end

  def admin
    holder
  end

  def interested(user)
    interested_users << user unless interested_users.include?(user)
  end

  def accept(own,user)
    if own == admin and is_open?
      if interested_users.include? user
        interested_users.delete user
        users << user
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
end
