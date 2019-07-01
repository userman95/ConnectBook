require 'rails_helper'

RSpec.feature "Delete Comments", type: :feature do
  
  let(:user){ create(:user_with_posts, name: "Efrain",
      email: "e@mail.com", number_of_posts: 1) }
  let(:friend){ create(:user, name: "Orestis") }
  let(:comment){ create(:comment, user: user, post: user.posts.last) }
  let(:friend_comment){ create(:comment, user: friend,
    post: user.posts.last) }
  
  before :each do
    user
    visit new_user_session_path
    fill_in 'Email',  with: "e@mail.com"
    fill_in 'Password', with: "123456"
    click_button 'Log in'
  end

  scenario "when click on delete link" do
    comment
    visit user_path(user)
    

    within ".list-comment-item small" do
      expect(page).to have_css(".comment-delete-link", count: 1)
      find("a", class: "comment-delete-link").click
    end

    visit user_path(user)

    within ".likes-info-counters" do
      expect(page).to have_css(".comments-counter small", text: "0 comments")
    end

    expect(page).to have_selector(".list-comment-item", count: 0)
  end

  scenario "when it is created by a friend" do
    friend_comment
    
    visit user_path(user)

    within ".list-comment-item" do
      expect(page).to have_selector(".comment-delete-link", count: 0)
    end
  end
end
