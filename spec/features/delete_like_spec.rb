require 'rails_helper'

RSpec.feature "Delete Likes", type: :feature do
  let(:user){ create(:user, name: "Efrain", email: "e@mail.com") }

  before :each do
    user
    visit new_user_session_path
    fill_in 'Email',  with: "e@mail.com"
    fill_in 'Password', with: "123456"
    click_button 'Log in'
  end

  scenario "when click on button twice" do

    visit posts_path

    within "#new_post" do
      fill_in "post_content", with: "My new post"
      click_button "Post"
    end
    
    within ".like-display" do
      find("input", class: "likes").click
    end
    
    # We need to visit again the post index because the click in the like
    # button just returned a string with the partial for the like button
    visit posts_path

    within ".like-display" do
      find("a", class: "likes").click
    end
    
    visit posts_path
  
    within ".likes-info-counters" do
      expect(page).to have_css(".likes-counter small", text: "0")
    end
  end
end
