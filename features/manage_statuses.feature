Feature: Manage Statuses
	In order to make a deliverables schedule 
	As a user
	I want to create and manage statuses

Background:
  Given a logged in user


Scenario: Show Status
  Given a status exists with name: "preliminary", position: "1"
  When I go to the show page for that status
  Then I should see "preliminary" within "h1"
