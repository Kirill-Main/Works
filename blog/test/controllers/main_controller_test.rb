# frozen_string_literal: true

require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  def setup
    # should clear tables
    [Comment, Like, Post, User].map(&:destroy_all)
  end

  test 'should get index' do
    get '/'
    assert_response :success
  end
end
