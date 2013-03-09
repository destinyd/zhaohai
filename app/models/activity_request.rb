class ActivityRequest
  include Mongoid::Document
  include Mongoid::Timestamps
  field :text, type: String
  field :deal_at, type: Time
  belongs_to :user
  belongs_to :activity

  #validates :activity_id,uniqueness: {scope: :user_id},presence: true
  #validates :user_id,uniqueness: {scope: :activity_id},presence: true

  scope :undeal,where(deal_at: nil)
  scope :recent,order_by(created_at: :desc)

  attr_accessible :text,:activity_id

  def accept
    update_attribute :deal_at, Time.now
    activity.accept(user)
  end

  def accept_by(admin)
    accept
    user.notifications.create!({
      reply_admin: admin,
      activity: activity,
      reply_status: :accept},
      Notification::ActivityReply)
  end


  def deny
    update_attribute :deal_at, Time.now
  end

  def deny_by(admin)
    deny
    user.notifications.create!({
      reply_admin: admin,
      activity: activity,
      reply_status: :deny},
      Notification::ActivityReply)
  end

  def could_manage?(user)
    activity.could_manage?(user)
  end

  def could_join?(user)
    activity.could_join?(user)
  end

  def self_managed
    false
  end

  after_create do 
    if self.activity
      self.activity.interested(self.user)
      self.activity.admins.each do |admin|
        admin.notifications.create!({
          interesting_user: self.user,
          activity: activity,
          activity_request: self,
          text: self.text},
          Notification::InterestedActivity)
      end
    end
  end

end
