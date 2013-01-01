class NotificationsController < InheritedResources::Base
  actions :all,except: [:edit,:update,:new,:create]
  before_filter :authenticate_user!

  skip_load_and_authorize_resource only: :index

  def show
    show! do 
      @notification.read!
    end
  end

  def read
    current_user.notifications.read.recent.page params[:page]
  end

  protected
  def begin_of_association_chain
    current_user
  end

  def collection
    @notifications ||= end_of_association_chain.unread.recent.page params[:page]
  end
end
