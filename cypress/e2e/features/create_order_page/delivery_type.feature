Feature: Delivery Type


    Scenario Outline: Verify selecting between delivery type
        Given User is on the create order page
        When User selects Delivery Type index as "<Index>" and type as "<Type>"
        And User enters amount and selects currency type if cash delivery
            | amount        | 20  |
            | currencyIndex | 1   |
            | currency      | ILS |
        Then User should see the correct delivery type selected as "<Type>" at "<Index>"
        Examples:
            | Index | Type             |
            | 1     | Cash on Delivery |


