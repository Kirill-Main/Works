# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    user = User.new(name: 'Example Name', email: 'user@yandex.ru', phone: '89150051550', password: '12345')
    user.save
    @product = Product.new(user_id: user.id, name: 'Test', main: 'Example', price: 1000)
  end

  test 'should be valid' do
    assert @product.valid?
  end
end
