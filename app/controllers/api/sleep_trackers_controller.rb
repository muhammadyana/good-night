module Api
  class SleepTrackersController < BaseController
    before_action :set_sleep_tracker, only: [:show, :update, :destroy]

    # GET /sleep_trackers
    def index
      @sleep_trackers = SleepTracker.desc
      @sleep_trackers = @sleep_trackers.where(user_id: params[:user_id]) if params[:user_id]
      responder(:ok, 'OK', SleepTrackerSerializer.new(@sleep_trackers))
    end

    # GET /sleep_trackers/1
    def show
      responder(:ok, 'OK', SleepTrackerSerializer.new(@sleep_tracker))
    end

    # POST /sleep_trackers
    def create
      @sleep_tracker = SleepTracker.new(sleep_tracker_params)
      @sleep_tracker.clock_in = Time.zone.now # take time by user timezone
      if @sleep_tracker.save
        responder(:ok, 'Success create sleep tracker', SleepTrackerSerializer.new(@sleep_tracker))
      else
        responder(:unprocessable_entity, @sleep_tracker.errors.full_messages.to_sentence, errors: @sleep_tracker.errors)
      end
    end

    # PATCH/PUT /sleep_trackers/1
    def update
      if @sleep_tracker.update(sleep_tracker_params)
        responder(:ok, 'Data updated', SleepTrackerSerializer.new(@sleep_tracker))
      else
        responder(:unprocessable_entity, @sleep_tracker.errors.full_messages.to_sentence, errors: @sleep_tracker.errors)
      end
    end

    # DELETE /sleep_trackers/1
    def destroy
      @sleep_tracker.destroy
    end

    def clock_in
      current_user.clock_in
      sleep_record = current_user.sleep_trackers.active.first
      responder(:ok, "Success clock in in #{sleep_record.clock_in.to_s(:stamp)}", SleepTrackerSerializer.new(sleep_record))
    end

    def clock_out
      sleep_record = current_user.sleep_trackers.active.first

      return responder(:unprocessable_entity, "Sleep tracker has been clocked out, your latest record clocked out in #{current_user.sleep_trackers.last.clock_out&.to_s(:stamp)}") unless sleep_record

      if sleep_record
        sleep_record.update(clock_out: Time.zone.now)
        responder(:ok, "Success clock out in #{sleep_record.clock_out.to_s(:stamp)}", SleepTrackerSerializer.new(sleep_record))
      else
        responder(:unprocessable_entity, "There is no active sleep record")
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_sleep_tracker
      @sleep_tracker = SleepTracker.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sleep_tracker_params
      params.require(:sleep_tracker).permit(:user_id, :sleep_type)
    end
  end
end
