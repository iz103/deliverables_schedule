@deliverables

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
	
Scenario: Show Deliverable
  Given a deliverable: "deliverable" exists with number: "123", title: "drainage drawing", discipline: "Drainage"
  And a status: "status" exists with name: "A"
  And a delivery exists with deliverable: deliverable, status: status
  When I go to the deliverable page
  Then I should see "123"
  When I go to the deliverable's deliveries page
  # Then I should see "Deliveries"
      
	
# Scenario: Deliverable show
#   Given I have a deliverable numbered 123
#   When I go to the deliverable page
#   Then I should see "123"



# Scenario: List deliveries for a deliverable
#   Given I have a deliverable number 123
#   And I have a delivery planned date 01/01/2011
#  #And the delivery belongs with deliverable
#   # When I go to the deliverable page
#   # Then I should see "123"







# Then show me the page

