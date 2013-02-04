module Api::V1
  class ActivityRequestsController < ApiController
    doorkeeper_for :all
    respond_to :json

    def create
      @activity_request = current_resource_owner.activity_requests.new(
        (params[:activity_request] || {}).merge(
          activity_id: params[:activity_id])
      )
      if @activity_request.save
        render :json => @activity_request.to_json, :status => :ok
      else
        render :json=> @activity_request.errors, :status=>422
      end
    end

    def accept
      @activity_request = ActivityRequest.find(params[:id])
      @activity_request.accept_by(current_resource_owner) if can?(:accept,@activity_request)
      begin
        current_resource_owner.notifications.find(params[:notification_id]).destroy
      rescue
      end
    end

    def deny
      @activity_request = ActivityRequest.find(params[:id])
      @activity_request.deny_by(current_resource_owner) if can?(:deny,@activity_request)
      begin
        current_resource_owner.notifications.find(params[:notification_id]).destroy
      rescue
      end
    end
  end
end
