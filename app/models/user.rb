# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  # Extends ...................................................................
  # Includes ..................................................................
  # Variables .................................................................
  # Fields (If use mongo) .....................................................
  # Relationships .............................................................
  has_many :sleep_trackers, dependent: :destroy
  has_many :following_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followings, through: :following_users, source: :followed
  has_many :followed_users, foreign_key: :followed_id, class_name: 'Follow'
  has_many :followers, through: :followed_users
  # Validations ...............................................................
  # Callbacks .................................................................
  # Scopes ....................................................................
  # Uploaders / active storage.................................................
  # Additional config (i.e. accepts_nested_attributes_for etc...) .............
  # Auditeds ..................................................................
  # Enums .....................................................................
  # Delegate ..................................................................

  def clock_in
    return false if sleep_trackers.active.exists?

    sleep_trackers.create(clock_in: Time.zone.now)
  end

  def clock_out
    sleep_record = sleep_trackers.active.first

    return false unless sleep_record

    sleep_record.update(clock_out: Time.zone.now)
  end

  def following?(user)
    followings.include? user
  end

  def followback?(user)
    user.followers.include? self
  end

  def follow(user)
    return if following?(user)

    followings << user
  end

  def unfollow(user)
    followed_users.find_by(followed_id: user.id)&.destroy
  end

  def following_sleep_records_past_week
    following_ids = following_users.pluck(:followed_id)
    SleepTracker.where(user_id: following_ids).
      where('clock_out >= ?', 1.week.ago.beginning_of_day).
      where.not(clock_out: nil).
      order(duration: :desc)

    # SleepTracker.where(user_id: following_ids).
    #   where('clock_out >= ?', 1.week.ago.beginning_of_day).
    #   where.not(clock_out: nil).
    #   select('sleep_trackers.*, (sleep_trackers.clock_out - sleep_trackers.clock_in) as sleep_length').
    #   order('sleep_length DESC')
  end
end
