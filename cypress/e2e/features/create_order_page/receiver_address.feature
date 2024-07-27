Feature: Receiver Address

     Scenario: Verify changing receiver address
          Given User is on the create order page
          When User clicks on choose from my list button
          And User Click on the select button for the in the addresses list
               | Field          | Value            |
               | Name           | Test             |
               | PhoneNumber    | 0599343877       |
               | Province       | West Bank        |
               | Governorate    | Tulkarm District |
               | City           | Tulkarm          |
               | Area           | Attil            |
               | Address        | Jordan           |
               | AdditionalInfo | Village          |
          Then The receiver address should be changed correctly
               | Field          | Value            |
               | Name           | Test             |
               | PhoneNumber    | 0599343877       |
               | Province       | West Bank        |
               | Governorate    | Tulkarm District |
               | City           | Tulkarm          |
               | Area           | Attil            |
               | Address        | Jordan           |
               | AdditionalInfo | Village          |
