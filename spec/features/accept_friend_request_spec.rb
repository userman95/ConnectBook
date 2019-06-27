require 'rails_helper'

RSpec.feature "Accept FriendRequests", type: :feature do
  let(:user){ create(:user, email: "e@mail.com") }
  let(:friend){ create(:friend, email: "m@mail.com") }
  let(:friend_request){ create(:friend_request, user: user, friend: friend) }

  before :each do
    friend

    visit new_user_session_path
    fill_in "Email", with: "m@mail.com"
    fill_in "Password", with: "123456"
    click_button "Log in"
  end

  scenario "when click on Accept button" do
    friend_request

    visit friend_requests_path

    expect(page).to have_css(".friend-requests", count: 1)

    find("input", class: "accept").click

    visit friend_requests_path

    expect(page).to have_css(".friend-requests", count: 0)

    visit friendships_path

    expect(page).to have_css(".suggested-users", count: 1)
  end
end
