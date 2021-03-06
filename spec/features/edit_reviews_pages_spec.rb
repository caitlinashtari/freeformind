require 'rails_helper'

describe 'the reviews edit path' do

  it 'allows users to edit their reviews' do
    user = FactoryGirl.create(:user)
    product = FactoryGirl.create(:product)
    review = FactoryGirl.create(:review, :user_id => user.id, :product_id => product.id)
    visit new_user_session_path
    fill_in "Email", :with => "caitlin@caitlin.com"
    fill_in "Password", :with => "password"
    click_button "Log in"
    visit edit_product_review_path(product, review)
    fill_in "Author", :with => "You"
    click_button "Save"
    expect(page).to have_content("You")
  end

  it 'redirects to review edit if review edit is not saved' do
    user = FactoryGirl.create(:user)
    product = FactoryGirl.create(:product, :user_id => user.id)
    review = FactoryGirl.create(:review, :user_id => user.id, :product_id => product.id)
    visit new_user_session_path
    fill_in "Email", :with => "caitlin@caitlin.com"
    fill_in "Password", :with => "password"
    click_button "Log in"
    visit edit_product_review_path(product.id, review.id)
    fill_in "Author", :with => ""
    click_button "Save"
    expect(page).to have_content("Oops!")
  end
end
