class Notification::ActivityReply < Notification::Base
  include Mongoid::Symbolize
  belongs_to :reply_admin, :class_name => 'User',inverse_of: nil
  belongs_to :activity,inverse_of: nil
  symbolize :reply_status,in: [:accept,:deny]

  def as_json(options={})
    if options.blank?
      options[:except] = [:reply_admin_id,:activity_request_id]
      options[:include] = {
        activity: {
          except: [:user_ids,:user_id,:invited_user_ids,:interested_user_ids]
        },
        reply_admin: {
          only: [:_id,:name,:avatar]
        }
      }
    end
    super(options)
  end


end
