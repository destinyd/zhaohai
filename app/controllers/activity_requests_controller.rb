class ActivityRequestsController < InheritedResources::Base
  actions :all,except: [:destroy,:edit,:update]
  belongs_to :activity
  skip_load_and_authorize_resource :activity_request, through: :activity_id,only: :create
  before_filter :authenticate_user!, except: [:type,:expired,:running,:index]
  respond_to :html
  respond_to :js, only: [:new,:accept,:deny]

  def create
    @activity_request = current_user.activity_requests.create(
      (params[:activity_request] || {}).merge(
        activity_id: params[:activity_id])
    )
    redirect_to activity_path(params[:activity_id])
    #create!{@activity}
  end

  def accept
    @activity_request = ActivityRequest.find(params[:id])
    @activity_request.accept_by(current_user) if can?(:accept,@activity_request)
    begin
      current_user.notifications.find(params[:notification_id]).destroy
    rescue
    end
    if request.xhr?
      render :remove_notification
    else
      redirect_to :back
    end
  end

  def deny
    @activity_request = ActivityRequest.find(params[:id])
    @activity_request.deny_by(current_user) if can?(:deny,@activity_request)
    begin
      current_user.notifications.find(params[:notification_id]).destroy
    rescue
    end
    if request.xhr?
      render :remove_notification
    else
      redirect_to :back
    end
  end

  protected
  def begin_of_association_chain
    current_user unless ['index','show','new'].include?(action_name)
  end

  def collection
    @activity_requests ||= end_of_association_chain.undeal.accessible_by(current_ability).page params[:page]
  end
end
