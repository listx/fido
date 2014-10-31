require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user attributes must not be empty" do
    # Create an empty user object (everything set to 'nil').
    user = User.new
    # Such an empty user should not be able to pass validation.
    assert user.invalid?
    # An empty user object must have errors for the various attributes that
    # cannot be empty.
    assert user.errors[:name].any?
    assert user.errors[:password].any?
  end
  test "should not create user if name is not unique case-insensitively" do
    # The user "BOB" should fail because it is not unique case-insensitively
    # against user "bob" in test/fixtures/users.yml.
    user = User.new name: "BOB", password_digest: BCrypt::Password.create('ok')

    assert user.invalid?
  end
end
