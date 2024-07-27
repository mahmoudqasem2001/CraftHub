Feature: Package Type
    
    Scenario Outline: Verify switching between packaging type
        Given User is on the create order page
        When User selects Packaging Type index as "<Index>" and type as "<Type>"
        Then User should see the correct packaging type selected as "<Type>"
        Examples:
            | Index | Type                     |
            | 0     | Small Package & Envelops |
            | 1     | Large Package            |
            | 2     | Medium Package           |