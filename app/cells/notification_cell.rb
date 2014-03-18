class NotificationCell < Cell::Rails
  helper ApplicationHelper

  def interested_activity(args)
    get_notification_and_render(args)
  end

  def activity_reply(args)
    get_notification_and_render(args)
  end

  def follower(args)
    get_notification_and_render(args)
  end

  def invited(args)
    get_notification_and_render(args)
  end

  def activity_status_change(args)
    get_notification_and_render(args)
  end

  private
  def get_notification_and_render(args)
    @notification = args[:notification]
    render
  end

end
