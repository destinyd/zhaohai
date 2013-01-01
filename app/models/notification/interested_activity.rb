class Notification::InterestedActivity < Notification::Base
  belongs_to :interesting_user, :class_name => 'User',inverse_of: nil
  belongs_to :activity,inverse_of: nil
  belongs_to :activity_request,inverse_of: nil
end
