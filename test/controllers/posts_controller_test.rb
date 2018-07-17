require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@one = users(:one)
		sign_in @one
	end

  test "should get home" do
  	get root_path
  	assert_response :success
  	assert_select "title", "JBook"
  end
end
