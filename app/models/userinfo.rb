class Userinfo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Symbolize

  field :realname, type: String
  #field :gender, type: Boolean#, :default => false
  symbolize :gender,in: [:female,:male]
  field :status, type: String
  #belongs_to :home,class_name: 'City'
  #belongs_to :now,class_name: 'City'
  field :home, type: String
  field :now, type: String
  field :birth, type: Date,default: DateTime.parse('1990 January')
  field :work, type: String
  field :school, type: String
  #embedded_in :user
  belongs_to :user
  #validates :gender,presence: true
  validates :birth,presence: true

  scope :recent,order_by(created_at: :desc)

  def name
    user.name
  end
end
