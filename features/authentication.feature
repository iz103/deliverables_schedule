Feature: Manage deliverables schedule
  In order to manage the deliverables schedule
  Users to the application
  Should be able to signup, login and logout

# Scenario: Not Logged in
#   Given I do not have a username and password
#   When I go to the list of deliverables
#   Then I should see "Oops, you need to be logged in to access this page"

Scenario: Signup
  Given I go to the signup page
  When I fill in the following:
    | Login | IzIz |
    | Email | iziz@iziz.com |
    | Password | 123456 |
    | Confirm Password | 123456 |
  And I press "Sign up"
  Then I should see "Thank you for signing up"



Scenario: Log in
  Given I am a valid user
  When I go to the login page
  And  I fill in the following:
    | Login | iz |
    | Password | 123456|
  And I press login
  Then I should see "Welcome Iz"
  