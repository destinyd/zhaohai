class ActivityRequest
  include Mongoid::Document
  include Mongoid::Timestamps
  field :text, type: String
  field :deal_at, type: Time
  belongs_to :user
  belongs_to :activity

  validates :activity_id,uniqueness: {scope: :user_id}

  scope :undeal,where(deal_at: nil)
  scope :recent,order_by(created_at: :desc)

  attr_accessible :text,:activity_id

  def accept
    update_attribute :deal_at, Time.now
    activity.accept(user)
  end

  def deny
    update_attribute :deal_at, Time.now
  end

  def self_managed
    false
  end

  after_create do 
    activity.interested(user)
  end

end
