class Notification::Invited < Notification::Base
  belongs_to :invite_user, :class_name => 'User',inverse_of: nil
  belongs_to :activity,inverse_of: nil
end
