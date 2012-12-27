class Province
  include Mongoid::Document
  field :name, type: String
  validates :name, uniqueness: true,presence: true
  has_many :cities,dependent:  :destroy
  accepts_nested_attributes_for :cities
  attr_accessible :name, :cities_attributes
  index({ name: 1 }, { unique: true, background: true })
end
