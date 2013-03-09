module Api::V1
  class ActivitiesController < ApiController
    doorkeeper_for :all
    respond_to :json

    def index
      @activities = Activity.index.page params[:page]
      render json: @activities.to_json
    end

    def show
      @activity = Activity.find(params[:id])
      render json: @activity.as_json(include: [:user,:users,:interested_users],methods: :status)
    end

    def create
      @activity = current_resource_owner.activities.new params[:activity]
      if @activity.save
        render :json => @activity.to_json, :status => :ok
      else
        render :json=> @activity.errors, :status=>422
      end
    end


    #custom_actions :collection => :expired
    def type
      @activities = Activity.tagged_with_on(:types,params[:type_name]).page params[:page]
      respond_with @activities
    end

    def expired
      @activities = Activity.expired.page params[:page]
      respond_with @activities
    end

    def running
      @activities = Activity.running.page params[:page]
      respond_with @activities
    end

    def close
      current_resource_owner.activities.find(params[:id]).close
    end

    def invite
      @activity = current_resource_owner.activities.find(params[:id]).invite(params[:ids])
      if @activity
        render :json => @activity.to_json, :status => :ok
      else
        render :json=> '', :status=>422
      end
    end


    def quit
      @activity = current_resource_owner.quit_activity(params[:id])
      if @activity
        render :json => @activity.to_json, :status => :ok
      else
        render :json=> '', :status=>422
      end
    end

    def info
      @activity = Activity.find(params[:id])
      respond_with @activity
    end

    def points
      @activities = Activity.points(params[:city])
      respond_with @activities
    end
  end
end
