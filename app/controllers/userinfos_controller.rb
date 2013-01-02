class UserinfosController < InheritedResources::Base
  actions :all,except: [:destroy,:new,:create]
  before_filter :authenticate_user!, only: [:new,:create,:edit,:update]
  skip_load_and_authorize_resource :only => :index

  def update
    update!{userinfos_path}
  end

  protected
  def begin_of_association_chain
    current_user unless ['index','show'].include?(action_name)
  end
  def collection
    @userinfos ||= end_of_association_chain.recent.accessible_by(current_ability).page params[:page]
  end

end
