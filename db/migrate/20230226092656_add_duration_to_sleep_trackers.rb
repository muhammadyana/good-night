class AddDurationToSleepTrackers < ActiveRecord::Migration[6.1]
  def change
    add_column :sleep_trackers, :duration, :integer, default: 0
  end
end
