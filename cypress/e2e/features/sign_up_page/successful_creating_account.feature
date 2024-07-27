Feature: Create Account

    Scenario: Successfully create a new account as a client
        Given User visits the create account page
        When User uploads a profile image with the file name "profile.jpg"
        When User selects "client" as the user type
        And User fills in personal information
            | Field       | Value        |
            | firstName   | khb          |
            | lastName    | kj           |
            | email       | kj@gmail.com |
            | phoneNumber | 0527243305   |

        And User fills in the ID number with "123456789"
        And User fills in business information with "test", "test"
        And User selects "1" as the business type
        And User submits the form
        Then User should see the confirmation modal
        And User fills model code and submit
        And User Go to Account page
        Then All personal information should be matched what user filled
            | Field            | Value        |
            | firstName        | khb          |
            | lastName         | kj           |
            | email            | kj@gmail.com |
            | phoneNumber      | 0527243305   |
            | businessName     | test         |
            | businessLocation | test         |



