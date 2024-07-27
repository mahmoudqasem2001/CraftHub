import { User } from "../helpers/user_model"

export class AccountDetailsPage {

    URLs = {
        accountDetailsPage: '/account/account-details'
    }

    elements = {
        accountContainer: () => cy.getDataTest('account-container'),
        profilePicture: () => cy.getDataTest('profile-picture'),
        userFullName: () => cy.getDataTest('user-full-name'),
        userEmail: () => cy.getDataTest('user-email'),
        businessName: () => cy.getDataTest('business-name-input'),
        businessPlace: () => cy.getDataTest('business-place-input'),
        businessType: () => cy.getDataTest('business-type'),
        updateButton: () => cy.getDataTest('update-button'),
    }

    actions = {
        navigateToAccountDetails: () => {
            cy.visit(this.URLs.accountDetailsPage);
        },
    }

    assertions = {
        verifyUserInformation: (userModel: User) => {
            this.elements.userFullName().should('contain', `${userModel.firstName} ${userModel.lastName}`);
            this.elements.userEmail().should('contain', userModel.email);
            this.elements.profilePicture().should('be.visible');
        },

        verifyBusinessInformation: (businessName: string, businessPlace: string, businessType: string) => {
            this.elements.businessName().should('have.value', businessName);
            this.elements.businessPlace().should('have.value', businessPlace);
        }
    }
}