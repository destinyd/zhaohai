class Notification::Base
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Relations::Referenced
  field :text, type: String
  field :read_at, type: DateTime

  embedded_in :user, :inverse_of => :notifications

  scope :unread,where(read_at: nil)
  scope :read,where(:read_at.exists => true)
  scope :recent,order_by(created_at: :desc)

  def has_read?
    !!read_at
  end

  def read!
    update_attribute :read_at,Time.now unless has_read?
  end

  def type_name
    self._type.split('::').last.tableize.singularize
  end

  def destroy
    read!
  end
end
