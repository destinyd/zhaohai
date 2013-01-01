class Notification::ActivityReply < Notification::Base
  include Mongoid::Symbolize
  belongs_to :reply_admin, :class_name => 'User',inverse_of: nil
  belongs_to :activity,inverse_of: nil
  symbolize :reply_status,in: [:accept,:deny]
end
