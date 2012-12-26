class UserinfosController < InheritedResources::Base
  actions :all,except: [:destroy,:new,:create]
  before_filter :authenticate_user!, only: [:new,:create,:edit,:update]

  def index
    @userinfo = current_user.userinfo
  end

  def edit
    @userinfo = current_user.userinfo if current_user.userinfo.id.to_s == params[:id]
    edit!
  end

  def update
    @userinfo = current_user.userinfo if current_user.userinfo.id.to_s == params[:id]
    update!{userinfos_path}
  end
end
