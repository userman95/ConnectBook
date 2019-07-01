require 'rails_helper'

RSpec.feature "Create Comments", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  # let(:user){ create(:user, name: "Efrain", email: "e@mail.com") }
  # let(:post){ create(:post, user: user) }

  # before :each do
  #   user
  #   visit new_user_session_path
  #   fill_in 'Email',  with: "e@mail.com"
  #   fill_in 'Password', with: "123456"
  #   click_button 'Log in'
  # end

  # scenario "when press enter on comment box" do
  #   post
  #   visit posts_path

  #   within ".likes-info-counters" do
  #     expect(page).to have_css(".comments-counter small", text: "0 comments")
  #   end

  #   within ".comment-form form" do
  #     fill_in "comment_content", with: "Comment for new post"
  #     find("input", id: "comment_content").send_keys(:enter)
  #   end

  #   # visit posts_path

  #   within ".likes-info-counters" do
  #     expect(page).to have_css(".comments-counter small", text: "1 comment")
  #   end
  # end
end
