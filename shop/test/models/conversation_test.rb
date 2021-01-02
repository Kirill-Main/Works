# frozen_string_literal: true

require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  def setup
    user = User.new(name: 'Example Name', email: 'user@yandex.ru', phone: '89150051550', password: '12345')
    user.save
    user1 = User.new(name: 'Example Name1', email: 'user1@yandex.ru', phone: '89150051555', password: '000')
    user1.save
    product = Product.new(user_id: user.id, name: 'Test', main: 'Example', price: 1000)
    product.save
    @conversation = Conversation.new(user_id: user1.id, product_id: product.id, quesstion: 'hello', answer: 'hey')
  end

  test 'should be valid' do
    assert @conversation.valid?
  end
end
