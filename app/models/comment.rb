class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :text, type: String
  validates_presence_of :text
  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
