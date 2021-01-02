# frozen_string_literal: true

require 'test_helper'

class IdiomTest < ActiveSupport::TestCase
  def setup
    @idiom = Idiom.new(
      str_from: 'весь мир у твоих ног', language_from: 'ru',
      str_to: 'the world is your oyster', language_to: 'en'
    )
  end

  test 'should save' do
    assert @idiom.save
  end

  test 'str_from should be present' do
    @idiom.str_from = ''
    assert_not @idiom.save
  end

  test 'str_to should be present' do
    @idiom.str_to = ''
    assert_not @idiom.valid?
  end

  test 'should not save a duplicate' do
    idiom_dup = @idiom.dup
    assert @idiom.save
    assert_not idiom_dup.save
  end

  test 'str_from should not be too long' do
    @idiom.str_from = 'a' * 51
    assert_not @idiom.valid?
  end

  test 'str_to should not be too long' do
    @idiom.str_to = 'a' * 51
    assert_not @idiom.valid?
  end
end
