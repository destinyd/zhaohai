class Notification::InterestedActivity < Notification::Base
  belongs_to :interesting_user, :class_name => 'User',inverse_of: nil
  belongs_to :activity,inverse_of: nil
  belongs_to :activity_request,inverse_of: nil

  def as_json(options={})
    if options.blank?
      options[:include] = {
        activity: {
          except: [:user_ids,:user_id,:invited_user_ids,:interested_user_ids]
        },
        activity_request: {
          except: [:user_id,:user_id,:activity_id]
        },
        interesting_user: {only: [:_id,:name,:avatar]}
      }
      options[:except] = [:activity_id,:interesting_user_id,:activity_request_id]
    end
    super(options)
  end

end
