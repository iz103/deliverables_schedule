Feature: Manage Deliverables
	In order to make a deliverables schedule 
	As a user
	I want to create and manage deliverables
	
Scenario: Deliverables List
	Given I have deliverables numbered 123, 124
	When I go to the list of articles
	Then I should see "123"
	And I should see "124"
	