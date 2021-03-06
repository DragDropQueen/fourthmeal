require './test/test_helper'
require_relative '../helpers/restaurant_helper'

class CheckoutAsGuestTest < Capybara::Rails::TestCase

  def setup
    Restaurant.destroy_all
  end

  def test_guest_user_has_option_to_checkout
    restaurant = create_valid_restaurant(:name => "Boyoh's")
    item1 = create_valid_item(restaurant.id)
    visit root_path
    first(:link, "Show").click

    within "#item_#{item1.id}" do
      click_on "Add to Cart"
    end

    click_on "Checkout"
    assert page.has_link?("Guest Checkout")
  end

  def test_guest_user_can_checkout
    Capybara.reset!
    Capybara.current_driver = :selenium
    restaurant = create_valid_restaurant(:name => "Boyoh's")
    item1 = create_valid_item(restaurant.id)
    visit root_path
    first(:link, "Show").click

    within "#item_#{item1.id}" do
      click_on "Add to Cart"
    end

    click_on "View Your Order"
    click_on "Checkout"

    within "#checkout-button-guest" do
      click_on "Guest Checkout"
    end

    within "#transaction-container" do
      assert page.has_content?("Transaction Information")
    end

    within "#new_transaction" do
      fill_in "First name", with: "Bob"
      fill_in "Last name", with: "Hope"
      fill_in "Email", with: "shopper@example.com"
      fill_in "Zipcode", with: "12345"
      fill_in "Credit Card", with: "4242424242424242"
      fill_in "CVC", with: "123"
      fill_in "Exp Month (MM)", with: "10"
      fill_in "Exp Year (YYYY)", with: "2020"
      click_on "Submit"
    end

    assert page.has_content?('Successfully created your order')
  end

end
