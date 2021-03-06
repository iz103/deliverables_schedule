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
	
Scenario: Show Deliverable and deliverable deliveries
  Given a deliverable: "001" exists with number: "123", title: "drainage drawing", discipline: "Drainage"
    And a status: "001" exists with name: "A"
    And a delivery exists with deliverable_id: "001", status_id: "001", planned_date: "01/12/2010"
    When I go to the deliverable page
    Then I should see "123"
  When I go to the deliverable's deliveries page
  Then I should see "A"
 

Scenario: Create deliverable delivery
  Given a deliverable: "001" exists with number: "123", title: "drainage drawing", discipline: "Drainage"
  And a status: "002" exists with name: "C"
  # When I go to the new deliverable's delivery page
  # Then I should see


# Then show me the page


# TODO:



# upload csv
# 



# 
# - in deliverables deliveries view, add checkbox to mark deliveries as delivered. DONE
# - only display the graph in the all deliveries  DONE
# - validations: date validations  DONE AS DATE IS SELECTED
# - add originator to deliveries, or person responsible (user).
# - flag late deliveries, early deliveries, deliveries due in the next 2 weeks, 1 week in deliveries dashboard
# - delete deliveries, deliverables and edit them DONE
# - date pick DONE
# - deliveries index: No. of overdue deliverables, next day, 1 week due deliverables, next 2 weeks
# - tags: disciplines, document types (drawing, document, etc.)
# - options for chart:
# - define preferences: project start date, project end date
# - dashboard:
# 	upcoming deliverables (today, tomorrow, next week, next 2 weeks)
# 	late deliverables (edit dates)
# - email alerts: (late deliverables, deliverables due, dashboard roundup)






# Before 1st of April
# - graph bug on ie7
# - link late deliveries to the list
# - percentage planned complete
# - user dashboard and message sent, activity feeds
# - table view for deliverables, etc.
# - sorting columns
# - 
