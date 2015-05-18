require 'spec_helper'
require 'rails_helper'

feature "create goals" do
  it "has a create goal form" do
    sign_up_as("Ryan")
    visit new_goal_url
    expect(page).to have_content("Create Goal")
  end

  it "redirects to user's page after creating goal and shows new goal" do
    sign_up_as("Ryan")
    visit new_goal_url
    fill_in("goal-body", with: "Finish the goal app")
    choose("goal-public")
    click_on("Create Goal")
    expect(page).to have_content("Finish the goal app")
    expect(page).to have_content("Ryan")
  end
end

feature "user can modify goal" do
  before(:each) do
    sign_up_as("Ryan")
    create_goal("Test goal")
  end

  it "has a link to edit" do
    expect(page).to have_content("Edit Goal")
  end

  it "has a button for completed" do
    expect(page).to have_button("Mark Completed")
  end

  it "has a button to delete the goal" do
    expect(page).to have_button("Delete Goal")
  end
end


feature "public vs private goals" do
  before(:each) do
    sign_up_as("Ryan")
    create_goal("Public Goal")
    create_goal("Private Goal", "private")
    click_on("Sign Out")
    sign_up_as("Joe")
    visit user_url(1)
  end

  it "user cannot see other user's private goals" do
    expect(page).to have_content("Public Goal")
    expect(page).to_not have_content("Private Goal")
  end

  it "user shouldn't be able to modify another user's goals" do
    expect(page).to_not have_content("Edit Goal")
    expect(page).to_not have_button("Mark Completed")
    expect(page).to_not have_button("Delete Goal")
  end
end

feature "user can update goals" do
  before(:each) do
    sign_up_as("Ryan")
    create_goal
  end

  it "should have an edit page" do
    visit edit_goal_url(1)
    expect(page).to have_content("Update Goal")
  end

  it "edits goal / expect public/private is pre-filled" do
    visit edit_goal_url(1)
    fill_in("goal-body", with: "Edited Goal")
    find_field("goal-public").should be_checked
    click_on("Update Goal")
    expect(page).to have_content("Ryan")
    expect(page).to have_content("Edited Goal")
  end

  it "changes completion status" do
    click_on("Mark Completed")
    expect(page).to have_content("Ryan")
    expect(page).to_not have_content("in progress")
    expect(page).to have_button("Mark In Progress")
  end

  it "deletes goals" do
    click_on "Delete Goal"
    expect(page).to have_content("Ryan")
    expect(page).to_not have_content("Test Goal")
  end
end
