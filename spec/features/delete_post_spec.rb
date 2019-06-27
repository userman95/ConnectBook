require 'rails_helper'

RSpec.feature "Delete Posts", type: :feature do
  
  let(:user){ create(:user, email: "e@mail.com") }
  let(:post){ create(:post, user: user) }

  before :each do
    user
    visit new_user_session_path
    fill_in 'Email',  with: "e@mail.com"
    fill_in 'Password', with: "123456"
    click_button 'Log in'
  end

  scenario "when click on delete button" do
    post

    visit posts_path
    
    within ".post-origin" do
      find("a", text: "Delete", visible: false).click
    end

    expect(page).to have_selector('.post-section', count: 0)
  end
end
