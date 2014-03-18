class ActivitiesController < InheritedResources::Base
  #custom_actions :collection => :expired
  before_filter :authenticate_user!, except: [:type,:expired,:running,:index,:show,:info,:points]
  respond_to :html,except: [:points,:invite_friend,:invite]
  respond_to :json,only: :points
  respond_to :js,only: [:invite_friend,:invite]
  layout false,only: [:info,:points,:invite_friend]
  skip_load_and_authorize_resource :only => :index
  def type
    @activities = Activity.tagged_with_on(:types,params[:type_name]).page params[:page]
  end

  def expired
    @activities = Activity.expired.page params[:page]
  end

  def running
    @activities = Activity.running.page params[:page]
  end

  def close
    current_user.activities.find(params[:id]).closed!
    redirect_to :back
  end

  def invite
    current_user.activities.find(params[:id]).invite(params[:ids])
  end

  def invite_friend
    @activity = current_user.activities.find(params[:id])
    @friend = current_user.friend - @activity.invited_users
  end

  def info
    @activity = Activity.find(params[:id])
  end

  def points
    @activities = Activity.points(params[:city])
    render json: @activities
  end

  def private
    @activities = Activity.private.opening.page(params[:page])
    render :index
  end
  protected
  def begin_of_association_chain
    current_user unless ['index','show'].include?(action_name)
  end
  def collection
    @activities ||= end_of_association_chain.public.opening.recent.accessible_by(current_ability).page params[:page]
  end
end
