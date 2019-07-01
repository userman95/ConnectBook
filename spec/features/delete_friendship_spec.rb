require 'rails_helper'

RSpec.feature "Delete Friendships", type: :feature do
  let(:user){ create(:user, email: "o@mail.com") }
  let(:friend){ create(:user, email: "e@mail.com") }
  let(:friend_request){ create(:friend_request, user: user, friend: friend) }
  let(:friendship){ create(:friendship, user: user, friend: friend) }

  before :each do
    user
    visit new_user_session_path

    fill_in "Email", with: "o@mail.com"
    fill_in "Password", with: "123456"
    click_button "Log in"
  end

  scenario "when click Delete Friend button" do
    friend_request
    friendship

    visit friendships_path
    # p page.body
    expect(page).to have_css(".suggested-users", count: 1)
  end
end
