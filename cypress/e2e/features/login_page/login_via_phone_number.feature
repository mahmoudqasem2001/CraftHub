Feature: Login

     Scenario: Login with existing valid phone number
          Given User goes to login via phone number
          When User Fills his phone number on input field
               | phoneNumber | 0599344870 |
          And User clicks on send button
          And User enters OTP code on OTP input field
               | otpCode | 8888 |
          And User clicks on login button
          Then User should be login successfully and redirected to homepage

     Scenario: Login with non-existent valid phone number
          Given User goes to login via phone number
          When User Fills his phone number on input field
               | phoneNumber | 0566344870 |
          And User clicks on send button
          Then Popup alert should shown with error message
               | message | Mobile not found! |

     Scenario: Login with wrong OTP code
          Given User goes to login via phone number
          When User Fills his phone number on input field
               | phoneNumber | 0599344870 |
          And User clicks on send button
          And User enters OTP code on OTP input field
               | otpCode | 4444 |
          And User clicks on login button
          Then Popup alert should shown with error message
               | message | Wrong Code! |

     Scenario: Login with invalid OTP code
          Given User goes to login via phone number
          When User Fills his phone number on input field
               | phoneNumber | 0599344870 |
          And User clicks on send button
          And User enters OTP code on OTP input field
               | otpCode | 44 |
          And User clicks on login button
          Then An error message for "code" should shown with "Enter four-digit Code!" message


     Scenario: Login with invalid phone number
          Given User goes to login via phone number
          When User Fills his phone number on input field
               | phoneNumber | 123 |
          And User clicks on send button
          Then An error message for "phoneNumber" should shown with "Please enter a valid phone number!" message
