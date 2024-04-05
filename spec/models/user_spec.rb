require 'rails_helper'

RSpec.describe User, type: :model do
  it "is not valid without an email" do
    user = User.new(password: "password", username: "example_user")
    expect(user).not_to be_valid
  end

  it "is not valid without a password" do
    user = User.new(email: "user@example.com", username: "example_user")
    expect(user).not_to be_valid
  end

  it "is not valid without a username" do
    user = User.new(email: "user@example.com", password: "password")
    expect(user).not_to be_valid
  end

  it "is not valid with a duplicate username" do
    existing_user = User.create(email: "existing@example.com", password: "password", username: "existing_user")
    user = User.new(email: "user@example.com", password: "password", username: "existing_user")
    expect(user).not_to be_valid
  end

  it "is valid with all required attributes" do
    user = User.new(email: "user@example.com", password: "password", username: "example_user")
    expect(user).to be_valid
  end
end
