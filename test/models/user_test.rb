require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should create user" do
    user = User.new(email: 'test3@mail.com', password: 'test12')
    assert user.save!
  end

  test 'should report error when password blank' do 
    user = User.new(email: 'test3@mail.com')
    error = assert_raise(ActiveRecord::RecordInvalid) do
      user.save!
    end
    assert_equal error.message, "Validation failed: Password can't be blank"
  end

  test 'should report error when password is too short' do 
    user = User.new(email: 'test3@mail.com', password: '1234')
    error = assert_raise(ActiveRecord::RecordInvalid) do
      user.save!
    end
    assert_equal error.message, "Validation failed: Password is too short (minimum is 6 characters)"
  end

  test 'should check if user exist in DB' do 
    assert_equal User.exists?(email: 'test1@mail.com'), true
  end
end
