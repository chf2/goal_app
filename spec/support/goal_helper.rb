module GoalHelper
  def create_goal(body = "Test Goal", option = "public")
    visit new_goal_url
    fill_in("goal-body", with: body)
    choose("goal-#{option}")
    click_on("Create Goal")
  end
end
