
Feature: Pickup Address

 Scenario: Verify adding new pickup address
        Given User is on the create order page
        When User clicks on change pickup address button
        And User clicks on add pickup address button
        And User Fills all address information
            | Field          | Value            |
            | Name           | Test             |
            | PhoneNumber    | 0599343877       |
            | Province       | West Bank        |
            | Governorate    | Tulkarm District |
            | City           | Tulkarm          |
            | Area           | Attil            |
            | Address        | Jordan           |
            | AdditionalInfo | Village          |

        And User clicks on the proceed button
        Then A new pickup address should be added to the addresses list
            | Field       | Value      |
            | Name        | Test       |
            | Address     | Jordan     |
            | City        | Tulkarm    |
            | PhoneNumber | 0599343877 |

    Scenario: Verify setting the default pickup address
        Given User is on the create order page
        When User clicks on change pickup address button
        And User clicks on the set default pickup address button at "<Index>" index
        Then The default pickup address should be set to the selected address as "<Address>"
        Examples:
            | Index | Address        |
            | 1     | Tulkarm, Attil |


    Scenario: Verify searching about pickup address functionality
        Given User is on the create order page
        When User clicks on change pickup address button
        And User Search for a specific address by "<Name>" and "<Mobile Number>"
        Then Pickup addresses should be filtered as "<Name>" and "<Mobile Number>"
        Examples:
            | Name    | Mobile Number |
            | Tulkarm | 0599344875    |