class NotificationCell < Cell::Rails
  helper ApplicationHelper

  def interested_activity(args)
    @notification = args[:notification]
    render
  end

  def activity_reply(args)
    @notification = args[:notification]
    render
  end

  def follower(args)
    @notification = args[:notification]
    render
  end

  def invited(args)
    @notification = args[:notification]
    render
  end

end
