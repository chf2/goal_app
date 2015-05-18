require 'spec_helper'
require 'rails_helper'

feature "user has a comment form on show page" do
  before(:each) { sign_up_as "Ryan" }

  it "form exists" do
    expect(page).to have_content("Add Comment")
  end

  it "displays comment author" do
    sign_up_as("Joe")
    visit user_url(1)
    fill_in("comment-body", with: "TestComment1")
    click_on("Add Comment")
    expect(page).to have_content("Joe")
  end

  feature "user can interact with form" do
    before(:each) do
      fill_in("comment-body", with: "TestComment1")
      click_on("Add Comment")
    end

    it "posts comment to page" do
      expect(page).to have_content("TestComment1")
    end

    it "comment has a delete button" do
      expect(page).to have_button("Delete Comment")
    end

    it "users cannot delete others' comments" do
      sign_up_as("Joe")
      visit user_url(1)
      expect(page).to_not have_button("Delete Comment")
    end

    it "comments can be deleted by author" do
      expect(page).to have_content("TestComment1")
      click_on("Delete Comment")
      expect(page).to_not have_content("TestComment1")
    end
  end
end

feature "comments on goals" do
  before(:each) do
    sign_up_as("Ryan")
    create_goal("Goal Comment Test")
  end

  it "should have a link to comment on goal" do
    expect(page).to have_content("Comment On Goal")
  end

  it "should take us to a comment form" do
    click_on("Comment On Goal")
    expect(page).to have_content("Goal Comment Test")
    expect(page).to_not have_content("Ryan")
    expect(page).to have_content("Add Comment")
  end

  feature "users can interact with goal comments" do
    before(:each) do
      click_on("Comment On Goal")
      fill_in("comment-body", with: "TestComment2")
      click_on("Add Comment")
    end

    it "adds comment to goal and redirects to user page" do
      expect(page).to have_content("Ryan")
      expect(page).to have_content("TestComment2")
    end

    it "users cannot delete others' comments" do
      sign_up_as("Joe")
      visit user_url(1)
      expect(page).to_not have_button("Delete Comment")
    end

    it "can be deleted by author" do
      expect(page).to have_button("Delete Comment")
      click_on("Delete Comment")
      expect(page).to_not have_content("TestComment2")
    end

    it "comments are listed on a goal's page" do
      visit(goal_url(1))
      expect(page).to have_content("TestComment2")
    end
  end
end
