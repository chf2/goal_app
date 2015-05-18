require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  it "has a new user page" do
    visit(new_user_url)
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do
    it "shows username on homepage after signup" do
      visit(new_user_url)
      fill_in("user-username", with: "user1")
      fill_in("user-password", with: "password")
      click_on("Sign Up")
      expect(page).to have_content("user1")
    end
  end

end

feature "logging in" do
  it "shows username on the homepage after login" do
    user = FactoryGirl.build(:user)
    User.create!(username: user.username, password: user.password)
    visit(new_session_url)
    fill_in("user-username", with: user.username)
    fill_in("user-password", with: user.password)
    click_on("Sign In")
    expect(page).to have_content(user.username)
  end

end

feature "logging out" do
  before(:each) do
    user = FactoryGirl.build(:user)
    @user = User.create!(username: user.username, password: user.password)
  end

  it "begins with logged out state" do
    visit(user_url(@user))
    expect(page).to have_content("Sign In")
  end

  it "doesn't show username on the homepage after logout" do
    visit(new_session_url)
    fill_in("user-username", with: @user.username)
    fill_in("user-password", with: @user.password)
    click_on("Sign In")
    expect(page).to have_content(@user.username)
    click_on("Sign Out")
    expect(page).to_not have_content(@user.username)
  end
end
