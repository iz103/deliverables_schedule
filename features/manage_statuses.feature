Feature: Manage Statuses
	In order to make a deliverables schedule 
	As a user
	I want to create and manage statuses

Background:
  Given a logged in user


Scenario: Show Status
  Given a status exists with name: "preliminary", position: "1", description: "issue for first approval"
  When I go to the show page for that status
  Then I should see "preliminary" within "h1"
  And I should see "issue for first approval"

Scenario: List Statuses
  Given the following statuses exist
    | name | position |
    | preliminary | 1 |
    | A | 2 |
  When I go to the list of statuses
  Then I should see "preliminary"
  And I should see "A"

Scenario: Create Status
  Given I go to new status page
  When I fill in the following:
    | Name | preliminary |
    | Position | 1 |
    | Description | issue for first approval |
  And I press "Create"
  Then I should see "New Status Successfully Created"

#TODO
# Scenario: Edit Status
# Scenario: Sort Statuses


