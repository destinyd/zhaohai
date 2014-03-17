class Notification::Invited < Notification::Base
  belongs_to :invite_user, :class_name => 'User',inverse_of: nil
  belongs_to :activity,inverse_of: nil

  def as_json(options={})
    if options.blank?
      options[:include] = {
        activity: {except: [:user_ids,:user_id,:invited_user_ids,:interested_user_ids]},
        invite_user: {only: [:_id,:name,:avatar]}
      }
      options[:except] = [:reply_admin_id,:invite_user_id]
    end
    super(options)
  end

  def accept!
    unless is_deal?
      old_enough = activity.min_person_enough?
      activity.users << user
      activity.invited_users.delete user
      deal
      new_enough = activity.reload.min_person_enough?
      activity.notify_success if !old_enough and new_enough
    end
  end

  def deny!
    unless is_deal?
      activity.invited_users.delete user
      deal
    end
  end
end
