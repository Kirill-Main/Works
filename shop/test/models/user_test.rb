# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example Name', email: 'user@yandex.ru', phone: '89150051550', password: '12345')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'phone should be present' do
    @user.phone = ''
    assert_not @user.valid?
  end

  test 'phone validation should accept valid phones' do
    valid_phones = %w[89170004045 89161115522 89159998765]
    valid_phones.each do |valid_phone|
      @user.phone = valid_phone
      assert @user.valid?, "#{valid_phones.inspect} should be valid"
    end
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'emails, names and surnames should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = "#{'a' * 244}@example.com"
    assert_not @user.valid?
  end

  test 'phone should not be too long' do
    @user.phone = '1' * 100
    assert_not @user.valid?
  end
end
