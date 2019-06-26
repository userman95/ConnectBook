require 'rails_helper'

RSpec.feature "Delete Posts", type: :feature do
  
  let(:user){ create(:user) }
  let(:post){ create(:post, user: user) }

  before :each do
    user
    visit new_user_session_path
    fill_in 'Email',  with: "user1@mail.c"
    fill_in 'Password', with: "123456"
    click_button 'Log in'
  end

  scenario "with existing id" do
    post

    visit posts_path
    
    within ".post-origin" do
      find("a", text: "Delete", visible: false).click
    end

    expect(page).to have_selector('.post-section', count: 0)
  end
end
