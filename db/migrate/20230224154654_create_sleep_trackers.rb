class CreateSleepTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :sleep_trackers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :sleep_type, default: 'sleep'
      t.datetime :clock_in

      t.timestamps
    end
  end
end
