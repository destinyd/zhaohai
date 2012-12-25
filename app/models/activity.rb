class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String, :default => ""
  field :desc, type: String
  validates_presence_of :title
  field :lat, type: Float
  field :lng, type: Float
  validates_presence_of :lat
  validates_presence_of :lng
  field :user_id, type: Integer
  field :started_at, type: Time
  field :finished_at, type: Time
  belongs_to :user

  index({
    :title => 1,
    :user_id => 1,
    :lat => 1,
    :lng => 1
  },
  { :unique => true})

  attr_accessible :title, :desc, :lat, :lng, :started_at, :finished_at
end
