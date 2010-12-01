Feature: Manage Deliverables
	In order to make a deliverables schedule 
	As a user
	I want to create and manage deliverables
# 	
Background:
  Given a logged in user
	
	
Scenario: Deliverables List
	Given I have deliverables numbered 123, 124
	When I go to the list of deliverables
	Then I should see "123"
	And I should see "124"




# # Scenario: List deliveries for a deliverable
#   Given I have a delivery numbered 0001
#   When I go to the delivery page
#   Then I should see "123"	

Need to say that it is associated with the delivery


# Then show me the page