Feature: Homepage
  As a user
  I want to visit the homepage
  So that I can access the various links on Page

  Scenario: Visit Homepage
    Given I am on the homepage
    Then I should see a "PHP Samples"
    When I click on "PHP Samples"
    Then I should find "Create a Web List."
