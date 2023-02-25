class RemoveSleeTypeInSleepTrackers < ActiveRecord::Migration[6.1]
  def change
    remove_column :sleep_trackers, :sleep_type
  end
end
