class AddClockOutToSleepTrackers < ActiveRecord::Migration[6.1]
  def change
    add_column :sleep_trackers, :clock_out, :datetime
  end
end
