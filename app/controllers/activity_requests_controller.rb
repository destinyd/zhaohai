class ActivityRequestsController < InheritedResources::Base
  actions :all,except: [:destroy,:edit,:update]
  belongs_to :activity
  authorize_resource
  before_filter :authenticate_user!, except: [:type,:expired,:running,:index]
  respond_to :html
  respond_to :js, only: [:new,:create]

  def create
    @activity_request = current_user.activity_requests.create(
      (params[:activity_request] || {}).merge(
        activity_id: params[:activity_id])
    )
    redirect_to :back
    #create!{@activity}
  end

  def accept
    @activity_request = ActivityRequest.find(params[:id])
    @activity_request.accept if can?(:accept,@activity_request)
    redirect_to :back
  end

  def deny
    @activity_request = ActivityRequest.find(params[:id])
    @activity_request.deny if can?(:deny,@activity_request)
    redirect_to :back
  end

  protected
  def begin_of_association_chain
    current_user unless ['index','show'].include?(action_name)
  end

  def collection
    @activity_requests ||= end_of_association_chain.accessible_by(current_ability).page params[:page]
  end
end
