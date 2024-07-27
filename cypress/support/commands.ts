/// <reference types="cypress" />

export { };

declare global {
  namespace Cypress {
    interface Chainable<Subject = any> {
      logout: () => Chainable<any>;
      login: (mobileNumber: string) => Chainable<any>;
      getDataTest: (selector: string) => Chainable<any>;
      getBySelLike: (selector: string) => Chainable<any>;

    }
  }

}


Cypress.Commands.add("getDataTest", (selector, ...args) => {
  return cy.get(`[data-test=${selector}]`, ...args);
});

Cypress.Commands.add("getBySelLike", (selector, ...args) => {
  return cy.get(`[data-test*=${selector}]`, ...args);
});

function login(mobileNumber: string) {
  cy.visit('/account/loginByPhoneNumber');
  cy.getDataTest('mobile-number-input').type(mobileNumber);
  cy.getDataTest('send-number-btn').click().then(() => {
    cy.getDataTest('OTP-code-input').type('8888')
    cy.getDataTest('submit-login').click().then(() => {
      cy.url().should('equal', 'https://dev.togo.ps/account/main/all-orders');
    })
  });


}

Cypress.Commands.add('login', login)