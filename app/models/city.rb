class City
  include Mongoid::Document
  field :name, type: String
  validates :name, presence: true
  belongs_to :province
  index({ name: 1,province_id: 1 }, {  background: true })
end
