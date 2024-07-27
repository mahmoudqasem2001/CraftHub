Feature: Failed Creating Account

    Scenario: Show error message for submitting empty requeired fields
        Given User visits the create account page
        When User submits the form
        Then User should see an error message in the modal field
        

    Scenario: Show error message when enter invlaid email
        Given User visits the create account page
        When User fills firstName as "Mahmoud", and lastName as "Qasem"
        And User fills invalid email as "<Email>"
        When User submits the form
        Then User should see an error message as "<Message>"
        Examples:
            | Email         | Message                             |
            | test          | Please include an '@'               |
            | testgmail.com | Please include an '@'               |
            | test@         | Please enter a part following '@'   |
            | @gmail.com    | Please enter a part followed by '@' |


   
