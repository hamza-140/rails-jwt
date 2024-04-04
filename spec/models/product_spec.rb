# spec/models/product_spec.rb

require 'rails_helper'

RSpec.describe Product, type: :model do
  subject {
    described_class.new(name: "Anything")
  }

  it "is not valid without price" do
    expect(subject).not_to be_valid
  end

  it "is not valid without a user" do
    product = Product.new(name: "Example Product", price: 10)
    expect(product).not_to be_valid
  end

  it "is valid with all required attributes" do
    user = User.create(email: "user@example.com", password: "password", username: "example_user")
    product = user.products.build(name: "Example Product", price: 10)
    expect(product).to be_valid
  end

  it "belongs to a user" do
    user = User.create(email: "user@example.com", password: "password", username: "example_user")
    product = user.products.build(name: "Example Product", price: 10)
    expect(product.user).to eq(user)
  end
end
