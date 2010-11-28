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

    # | Username | Email | Password | Password confirmation |
    #    | IzIz     | iziz@iziz.com | 123456 | 123456 |

    | Username | IzIz |
    | Email | iziz@iziz.com |
    | Password | 123456 |
    | Password confirmation | 123456 |
  And I press "Create"
  Then I should see "User was successfully created."



# Scenario: Log in
#   Given a valid user
#   When I go to the login page
#   And  I fill in the following:
#     | Username | IzIz |
#     | Password | 123456 |
#   And I press "Log in"
#   Then I should see "logged in"
  