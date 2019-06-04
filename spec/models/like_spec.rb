require 'rails_helper'

RSpec.describe Like, type: :model do

  before do
    @user = User.create(name: "Orestis",email: "o@mail.com",password: "123456")
    @friend = User.create(name: 'Efrain',email: "e@mail.com",password: "123456")
    @post = @user.posts.create(content: "tests for post model")
    @like = @user.likes.create(post_id: @post.id)
  end

  context "associations tests" do
    it "a like should belong to a post" do
      expect(@like.post.nil?).to be false
    end

    it "a like should belong to a user" do
      expect(@like.post.user).to_not be_nil
    end

    it "a like should be deleted when it's user is destroyed" do
      @user.destroy
      expect { @like.reload }.to raise_error ActiveRecord::RecordNotFound
    end

    it "a like should be deleted when it's post is destroyed" do
      @post.destroy
      expect { @like.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  context "validations tests" do
    it "a like should be valid" do
      expect(@like).to be_valid
    end
  end

end
