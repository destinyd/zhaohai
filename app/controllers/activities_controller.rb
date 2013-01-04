class ActivitiesController < InheritedResources::Base
  #custom_actions :collection => :expired
  before_filter :authenticate_user!, except: [:type,:expired,:running,:index,:show,:info,:points]
  respond_to :html,except: :points
  respond_to :json,only: :points
  layout false,only: [:info,:points]
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
    current_user.activities.find(params[:id]).close
    redirect_to :back
  end

  def info
    @activity = Activity.find(params[:id])
  end

  def points
    @activities = Activity.points(params[:city])
    render json: @activities
  end
  protected
  def begin_of_association_chain
    current_user unless ['index','show'].include?(action_name)
  end
  def collection
    @activities ||= end_of_association_chain.opening.recent.accessible_by(current_ability).page params[:page]
  end
end
