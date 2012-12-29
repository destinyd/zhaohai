class ActivitiesController < InheritedResources::Base
  #custom_actions :collection => :expired
  before_filter :authenticate_user!, only: [:new,:create,:edit,:update,:destroy]
  respond_to :html
  skip_load_and_authorize_resource :only => :index
  def type
    @activities = Activity.tagged_with_on(:types,params[:type_name])
  end

  def expired
    @activities = Activity.expired.page params[:page]
  end

  def running
    @activities = Activity.running.page params[:page]
  end
  protected
  def begin_of_association_chain
    current_user unless ['index','show'].include?(action_name)
  end
  def collection
    @activities ||= end_of_association_chain.opening.accessible_by(current_ability).page params[:page]
  end
end
