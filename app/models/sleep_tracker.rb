# == Schema Information
#
# Table name: sleep_trackers
#
#  id         :integer          not null, primary key
#  clock_in   :datetime         not null
#  clock_out  :datetime
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
class SleepTracker < ApplicationRecord
  # Extends ...................................................................
  # Includes ..................................................................
  # Variables .................................................................
  # Fields (If use mongo) .....................................................
  # Relationships .............................................................
  belongs_to :user
  # Validations ...............................................................
  # Callbacks .................................................................
  # Scopes ....................................................................
  # Uploaders / active storage.................................................
  scope :active, -> { where.not(clock_in: nil).where(clock_out: nil) }
  scope :unactive, -> { where.not(clock_in: nil, clock_out: nil) }
  # Additional config (i.e. accepts_nested_attributes_for etc...) .............
  # Auditeds ..................................................................
  # Enums .....................................................................
  enum sleep_type: { sleep: 'sleep', wake_up: 'wake_up' }, _prefix: true # we can use method SleepTracker.sleep_type_sleep or SleepTracker.sleep_type_wake_up to get related data
  # Delegate ..................................................................

  def duration
    return 0 unless clock_out?

    (clock_out - clock_in).to_i / 3600.0
  end
end
