# == Schema Information
#
# Table name: sleep_trackers
#
#  id         :integer          not null, primary key
#  clock_in   :datetime         not null
#  sleep_type :string           default("sleep")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_sleep_trackers_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class SleepTrackerSerializer < ApplicationSerializer
  attributes :id, :user_id, :sleep_type, :clock_in, :created_at, :updated_at
end
