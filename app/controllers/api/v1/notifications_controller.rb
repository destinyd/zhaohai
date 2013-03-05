module Api::V1
  class NotificationsController < ApiController
    doorkeeper_for :all
    respond_to :json

    def index
      @notifications = current_resource_owner.notifications.oread.recent.page params[:page]
      render json: @notifications.to_json
    end

    def show
      @notification = current_resource_owner.notifications.find(params[:id])
      @notification.read!
      render json: @notification.to_json
    end
  end
end
