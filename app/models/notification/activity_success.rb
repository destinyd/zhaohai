class Notification::ActivitySuccess < Notification::Base
  belongs_to :activity,inverse_of: nil

  def as_json(options={})
    if options.blank?
      options[:include] = {
        activity: {
          except: [:user_ids,:user_id,:invited_user_ids,:interested_user_ids]
        }
      }
      options[:except] = [:activity_id]
    end
    super(options)
  end
end
