Feature: Submit Order

    Scenario: Verify the submit order button with empty order information
        When User is on the create order page
        And User clicks on the submit order button
        Then An error should appear for filling in required fields

    Scenario: Verify Create a new Order with valid order inputs
        When User is on the create order page
        And User Fills all order information
            | Field          | Value            |
            | Amount         | 20               |
            | Name           | Test             |
            | PhoneNumber    | 0599343877       |
            | Province       | West Bank        |
            | Governorate    | Tulkarm District |
            | City           | Tulkarm          |
            | Area           | Attil            |
            | Address        | Jordan           |
            | AdditionalInfo | Village          |
        And User clicks on the submit order button
        Then A new order should be created with the following information and navigate into order page

    Scenario: Verify Create a new Order with invalid order inputs
        When User is on the create order page
        And User fills phone number as "01593325" fields with invalid input data
        And User clicks on the submit order button
        Then An error should appear for filling the valid data in input field






