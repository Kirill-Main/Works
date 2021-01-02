# frozen_string_literal: true

require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
  def setup
    user = User.new(name: 'Example', email: 'user@ex.com', password: '12345')
    user.save
    @translation = Translation.new(str_from: 'яблоко', str_to: 'apple', user_id: user.id)
  end

  test 'should be valid' do
    assert @translation.valid?
  end

  test 'str_from should be present' do
    @translation.str_from = ''
    assert_not @translation.save
  end

  test 'str_to should be present' do
    @translation.str_to = ''
    assert_not @translation.valid?
  end

  test 'str_from should not be too long' do
    @translation.str_from = 'a' * 51
    assert_not @translation.valid?
  end

  test 'str_to should not be too long' do
    @translation.str_to = 'a' * 51
    assert_not @translation.valid?
  end
end
