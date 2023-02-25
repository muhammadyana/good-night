# == Schema Information
#
# Table name: follows
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_follows_on_followed_id  (followed_id)
#  index_follows_on_follower_id  (follower_id)
#
# Foreign Keys
#
#  followed_id  (followed_id => followeds.id)
#  follower_id  (follower_id => followers.id)
#
require "test_helper"

class FollowTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
