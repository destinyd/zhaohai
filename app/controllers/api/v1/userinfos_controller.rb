#module Api::V1
  #class UserinfosController < ApiController
    #doorkeeper_for :all
    #actions :all,except: [:destroy,:new,:create,:index,:show]
    #before_filter :authenticate_user!, only: [:new,:create,:edit,:update]
    #skip_load_and_authorize_resource :only => :index

    #def update
      #update!{:back}
    #end

    #protected
    #def begin_of_association_chain
      #current_user
    #end
    #def collection
      #@userinfos ||= end_of_association_chain.accessible_by(current_ability).page params[:page]
    #end

  #end
#end
