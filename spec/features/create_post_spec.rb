require 'rails_helper'

RSpec.feature "Create Posts", type: :feature do

  let(:user){ create(:user, name: "Efrain", email: "e@mail.com") }

  before :each do
    user
    visit new_user_session_path
    fill_in 'Email',  with: "e@mail.com"
    fill_in 'Password', with: "123456"
    click_button 'Log in'
  end

  scenario "with valid info" do
    
    visit posts_path
    
    expect(current_path).to eq posts_path

    within "#new_post" do
      fill_in "post_content", with: "My new post"
      click_button "Post"
    end

    expect(page).to have_content "Post created"
    expect(page).to have_css ".post-section"
  end

  scenario "with invalid info" do
    
    visit posts_path
    
    expect(current_path).to eq posts_path

    within "#new_post" do
      fill_in "post_content", with: " "
      click_button "Post"
    end

    expect(page).to have_content "Post not created"
  end

  scenario "with picture" do

    visit posts_path

    expect(current_path).to eq posts_path

    within "#new_post" do
      fill_in "post_content", with: "Post with picture "
      attach_file("post_picture", file_fixture("test_image.jpg"))
      click_button "Post"
    end

    expect(page).to have_content "Post created"
    expect(page).to have_css ".posted-image"
  end
end
