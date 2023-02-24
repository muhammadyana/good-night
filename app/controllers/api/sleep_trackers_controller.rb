module Api
  class SleepTrackersController < BaseController
    before_action :set_sleep_tracker, only: [:show, :update, :destroy]

    # GET /sleep_trackers
    def index
      @sleep_trackers = SleepTracker.desc

      render json: @sleep_trackers
    end

    # GET /sleep_trackers/1
    def show
      responder(:ok, 'OK', data: @sleep_tracker)
    end

    # POST /sleep_trackers
    def create
      @sleep_tracker = SleepTracker.new(sleep_tracker_params)

      if @sleep_tracker.save
        render json: @sleep_tracker, status: :created, location: @sleep_tracker
      else
        render json: @sleep_tracker.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /sleep_trackers/1
    def update
      if @sleep_tracker.update(sleep_tracker_params)
        render json: @sleep_tracker
      else
        render json: @sleep_tracker.errors, status: :unprocessable_entity
      end
    end

    # DELETE /sleep_trackers/1
    def destroy
      @sleep_tracker.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_sleep_tracker
      @sleep_tracker = SleepTracker.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sleep_tracker_params
      params.require(:sleep_tracker).permit(:user_id, :clock_in, :sleep_type)
    end
  end
end
