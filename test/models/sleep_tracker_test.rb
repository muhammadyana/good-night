# == Schema Information
#
# Table name: sleep_trackers
#
#  id         :integer          not null, primary key
#  clock_in   :datetime
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
require "test_helper"

class SleepTrackerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
