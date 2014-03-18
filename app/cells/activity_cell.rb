class ActivityCell < Cell::Rails
  helper ApplicationHelper

  def running(args)
    deal(args)
    render
  end

  def opening(args)
    deal(args)
    render
  end

  def plan(args)
    deal(args)
    render
  end

  def expired(args)
    deal(args)
    render
  end

  def closed(args)
    deal(args)
    render
  end

  def success(args)
    deal(args)
    render
  end

  def failure(args)
    deal(args)
    render
  end

  private
  def deal(args)
    @activity = args[:activity]
    @user = args[:user]
  end
end
