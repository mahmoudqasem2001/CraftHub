export class LoginPage {
    URLs = {
        page: '/account/loginByPhoneNumber'
    }
    elements = {
        phoneNumberInput: () => cy.getDataTest('mobile-number-input'),
        sendButton: () => cy.getDataTest('send-number-btn'),
        otpInput: () => cy.getDataTest('OTP-code-input'),
        loginButton: () => cy.getDataTest('submit-login'),
        alertPopup: () => cy.getDataTest('alert-popup'),
        invalidNumberErrorMessage: () => cy.getDataTest('invalid-number-error-message'),
        invalidCodeErrorMessage: () => cy.getDataTest('invalid-code-message'),
    }
    actions = {
        navigateToLoginPage: () => {
            cy.visit(this.URLs.page);
        },
        fillPhoneNumber: (phoneNumber: string) => {
            this.elements.phoneNumberInput().type(phoneNumber);
        },
        clickSendButton: () => {
            this.elements.sendButton().click();
        },
        fillOtpCode: (otpCode: string) => {
            this.elements.otpInput().type(otpCode);
        },
        clickLoginButton: () => {
            this.elements.loginButton().click();
        },
    }
    assertions = {
        verifySuccessfulLogin: () => {
            cy.url().should('include', '/account/main/all-orders');

        },
        verifyAlertPopup: (message: string) => {
            cy.wait(3000);
            cy.get('.chakra-toast').within(() => {
                cy.get('div').contains(message);
            }).should('be.visible').and('contain.text', message);
        },

        verifyErrorMessageForField: (errorFor: string, message: string) => {
            if (errorFor == 'phoneNumber') {
                this.elements.invalidNumberErrorMessage().should('be.visible').and('contain.text', message);
            } else if (errorFor == 'code') {
                this.elements.invalidCodeErrorMessage().should('be.visible').and('contain.text', message);
            }
        }
    }
}