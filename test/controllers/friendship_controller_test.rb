require 'test_helper'

class FriendshipControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

  def setup
  	@one		= users(:one)
  	@two  	= users(:two)
  	@three 	= users(:three)
  	@four 	= users(:four)
  end

  test "should become friends after accepting" do
  	sign_in @one
  	@friendship = Friendship.create(requestor: @two, requested: @one)

  	get friend_accept_path(@friendship)
  	assert @one.friends_with(@two)
  	assert @two.friends_with(@one)
  end

  test "should not become friends after declining" do
  	sign_in @three
  	@friendship = Friendship.create(requestor: @four, requested: @three)

  	get friend_decline_path(@friendship)
  	assert_not @three.friends_with(@four)
  	assert_not @four.friends_with(@three)
  end

end
