class JoinActivityCell < Cell::Rails
  helper ApplicationHelper

  def true(args)
    deal(args)
    render
  end

  def false(args)
    deal(args)
    render
  end

  private
  def deal(args)
    @activity = args[:activity]
  end

end
