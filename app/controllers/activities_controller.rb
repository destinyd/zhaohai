class ActivitiesController < InheritedResources::Base
  before_filter :authenticate_user!, only: [:new,:create,:edit,:update,:destroy]
  respond_to :html
  skip_load_and_authorize_resource :only => :index
  protected
  def begin_of_association_chain
    current_user unless ['index','show'].include?(action_name)
  end
  def collection
    @activities ||= end_of_association_chain.accessible_by(current_ability)
  end
end
