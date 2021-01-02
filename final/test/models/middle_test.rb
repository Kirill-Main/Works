# frozen_string_literal: true

require 'test_helper'

class MiddleTest < ActiveSupport::TestCase
  def setup
    idiom = Idiom.new(
      str_from: 'весь мир у твоих ног', language_from: 'ru',
      str_to: 'the world is your oyster', language_to: 'en'
    )
    idiom.save
    user = User.new(name: 'Example', email: 'user@ex.com', password: '12345')
    user.save
    @middle = Middle.new(user_id: user.id, idiom_id: idiom.id, is_active: true)
  end

  test 'should save' do
    assert @middle.save
  end
end
