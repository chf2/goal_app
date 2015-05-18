module AuthHelper
  def sign_up_as(username = "example_user")
    visit(new_user_url)
    fill_in("user-username", with: username)
    fill_in("user-password", with: "password")
    click_on("Sign Up")
  end
end
