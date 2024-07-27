import 'cypress-file-upload';
import { User } from '../helpers/user_model';

export class CreateAccountPage {
    URLs = {
        createAccountPage: '/account/createAccount'
    }
    elements = {
        signupCard: () => cy.getDataTest('signup-card'),
        cardHeader: () => cy.getDataTest('card-header'),
        userTypeClient: () => cy.getDataTest('user-type-client'),
        userTypeTransporter: () => cy.getDataTest('user-type-transporter'),
        profileImage: () => cy.getDataTest('profile-image'),
        profileImageContainer: () => cy.getDataTest('profile-picture-wrapper'),
        uploadImageButton: () => cy.getDataTest('upload-image-button'),
        saveImageButton: () => cy.getDataTest('save-image-button'),
        firstNameInput: () => cy.getDataTest('first-name-input'),
        lastNameInput: () => cy.getDataTest('last-name-input'),
        emailInput: () => cy.getDataTest('email-input'),
        phoneNumberInput: () => cy.getDataTest('phone-number-input'),
        idNumberInput: () => cy.getDataTest('id-number-input'),
        businessNameInput: () => cy.getDataTest('business-name-input'),
        businessLocationInput: () => cy.getDataTest('business-location-input'),
        businessTypeSelect: () => cy.getDataTest('business-type-select'),
        submitButton: () => cy.getDataTest('submit-button'),
        alreadyHaveAccount: () => cy.getDataTest('already-have-account'),
        modalSubmitButton: () => cy.getDataTest('confirm-registration-button'),
        modalCodeInput: () => cy.getDataTest('confirmation-code-input'),
        // modalSubmitButton: () => cy.getDataTest('modal-submit-btn'),
        modalErrorMessage: () => cy.getDataTest('modal-error-message'),
    }

    actions = {
        visitCreateAccountPage: () => {
            cy.visit(this.URLs.createAccountPage);
        },
        selectUserType: (type: string) => {
            if (type === 'client') {
                this.elements.userTypeClient().click();
            } else if (type === 'transporter') {
                this.elements.userTypeTransporter().click();
            }
        },
        fillPersonalInformation: (userModel: User) => {
            this.elements.firstNameInput().clear().type(userModel.firstName);
            this.elements.lastNameInput().clear().type(userModel.lastName);
            this.elements.emailInput().clear().type(userModel.email);
            this.elements.phoneNumberInput().clear().type(userModel.phoneNumber);
        },
        fillIdNumber: (idNumber: string) => {
            this.elements.idNumberInput().clear().type(idNumber);
        },
        fillBusinessInformation: (businessName: string, businessLocation: string) => {
            this.elements.businessNameInput().clear().type(businessName);
            this.elements.businessLocationInput().clear().type(businessLocation);
        },
        selectBusinessType: (businessType: string) => {
            this.elements.businessTypeSelect().select(businessType);
        },
        submitForm: () => {
            this.elements.submitButton().click();
        },
        fillModalCode: (code: string) => {
            this.elements.modalCodeInput().clear().type(code);
        },
        submitModalForm: () =>
            this.elements.modalSubmitButton().click(),

        goToAccountDetailsPage: () => {
            cy.visit('/account/account-details');
        },

        uploadProfileImage: (fileName: string) => {
            const filePath = `${fileName}`;
            this.elements.profileImageContainer().within(() => {
                cy.get('button').click();
            })
            cy.fixture(filePath).then(fileContent => {
                cy.get('input[type="file"]').attachFile(filePath);
            });
            this.elements.saveImageButton().click();

        },

        clickAlreadyHaveAccount: () => {
            this.elements.alreadyHaveAccount().click();
        },

        fillUserName: (firstName: string, lastName: string) => {
            this.elements.firstNameInput().clear().type(firstName);
            this.elements.lastNameInput().clear().type(lastName);
        },

        fillUserEmail: (email: string) => {
            this.elements.emailInput().clear().type(email);
            this.elements.submitButton().click();
        }


    }
    assertions = {
        verifySignupCardVisible: () => {
            this.elements.signupCard().should('be.visible');
        },
        verifyUserTypeSelected: (type: string) => {
            if (type === 'client') {
                this.elements.userTypeClient().should('have.class', 'active');
            } else if (type === 'transporter') {
                this.elements.userTypeTransporter().should('have.class', 'active');
            }
        },
        verifyPersonalInformationFilled: (firstName: string, lastName: string, email: string, phone: string) => {
            this.elements.firstNameInput().should('have.value', firstName);
            this.elements.lastNameInput().should('have.value', lastName);
            this.elements.emailInput().should('have.value', email);
            this.elements.phoneNumberInput().should('have.value', phone);
        },
        verifyIdNumberFilled: (idNumber: string) => {
            this.elements.idNumberInput().should('have.value', idNumber);
        },
        verifyBusinessInformationFilled: (businessName: string, businessLocation: string) => {
            this.elements.businessNameInput().should('have.value', businessName);
            this.elements.businessLocationInput().should('have.value', businessLocation);
        },
        verifyBusinessTypeSelected: (businessType: string) => {
            this.elements.businessTypeSelect().should('have.value', businessType);
        },
        verifyModalVisible: () => {
            //  this.elements.modal().should('be.visible');
        },
        verifyModalErrorMessageVisible: () => {
            this.elements.firstNameInput().then(($el) => {
                expect($el[0].validationMessage).to.eq('Please fill out this field.');
            });
        },
        verifyModalErrorMessageNotVisible: () => {
            this.elements.modalErrorMessage().should('not.exist');
        },
        verifyNavigationToLogin: () => {
            cy.url().should('include', '/account/loginByPhoneNumber');
        },
        verifyEmailErrorMessageShown: (message: string) => {
            this.elements.emailInput().then(($el) => {
                expect($el[0].validationMessage).to.contains(message);
            });
        }


    }

    apis = {
        deleteUser: (functionName: string, phoneNumber: string,) => {
            cy.request({
                method: 'POST',
                url: 'https://togo.ps/togo/MobileAPi/public/FunctionApis.php',
                body: {
                    'CheckTypeFunction': functionName,
                    'phone': phoneNumber,
                },
                failOnStatusCode: false
            },
            );
        }
    }
}
