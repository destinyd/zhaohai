class Notification::Follower < Notification::Base
  belongs_to :follower, :class_name => 'User',inverse_of: nil
end
