require 'rails_helper'

RSpec.feature "Create FriendRequests", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  let(:user){ create(:user, email: "e@mail.com") }
  let(:friend){ create(:friend, email: "m@mail.com") }

  before :each do
    user

    visit new_user_session_path
    fill_in "Email", with: "e@mail.com"
    fill_in "Password", with: "123456"
    click_button "Log in"
  end

  scenario "when click on Add button" do
    friend

    visit users_path

    expect(page).to have_css(".suggested-users", count: 1)

    within ".button_to" do  
      find("input", class: "add-friend-button").click
    end

    visit users_path

    expect(page).to have_css(".suggested-users", count: 0)

    # Check invitation on friend session

    find("#Logout").click

    visit new_user_session_path

    fill_in "Email", with: "m@mail.com"
    fill_in "Password", with: "123456"
    click_button "Log in"

    visit friend_requests_path

    expect(page).to have_css(".suggested-users", count: 1)

  end
end
