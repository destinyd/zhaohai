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


end
