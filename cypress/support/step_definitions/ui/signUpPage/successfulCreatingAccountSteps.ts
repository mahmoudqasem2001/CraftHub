import { DataTable, Given, Then, When } from "@badeball/cypress-cucumber-preprocessor";
import { CreateAccountPage } from "../../../pageObjects/CreateAccountPage";
import { User } from "../../../helpers/user_model";
import { AccountDetailsPage } from "../../../pageObjects/AccountDetailsPage";

const createAccountPage = new CreateAccountPage();
const accountDetailsPage = new AccountDetailsPage();

Given('User visits the create account page', () => {
    createAccountPage.actions.visitCreateAccountPage();
});
When('User uploads a profile image with the file name {string}', (fileName: string) => {
    createAccountPage.actions.uploadProfileImage(fileName);
});

When('User selects {string} as the user type', (type: string) => {
    createAccountPage.actions.selectUserType(type);
});

When('User fills in personal information', (dataTable: DataTable) => {
    const userData = dataTable.rows().map(row => [row[0], row[1]] as [string, string]);
    console.log(userData);
    const userModel: User = User.fromArray(userData);
    createAccountPage.actions.fillPersonalInformation(userModel);
});

When('User fills in the ID number with {string}', (idNumber: string) => {
    createAccountPage.actions.fillIdNumber(idNumber);
});

When('User fills in business information with {string}, {string}', (businessName: string, businessLocation: string) => {
    createAccountPage.actions.fillBusinessInformation(businessName, businessLocation);
});

When('User selects {string} as the business type', (businessType: string) => {
    createAccountPage.actions.selectBusinessType(businessType);
});

When('User submits the form', () => {
    createAccountPage.actions.submitForm();
});


Then('User should see the confirmation modal', () => {
    createAccountPage.assertions.verifyModalVisible();
});

When('User fills model code and submit', () => {
    createAccountPage.actions.fillModalCode('8888');
    createAccountPage.actions.submitModalForm();
})

When('User Go to Account page', () => {
    cy.wait(3000);
    accountDetailsPage.actions.navigateToAccountDetails();
})

Then('All personal information should be matched what user filled', (dataTable: DataTable) => {
    const userData = dataTable.rows().map(row => [row[0], row[1]] as [string, string]);
    const userModel: User = User.fromArray(userData);
    accountDetailsPage.assertions.verifyUserInformation(userModel);
    accountDetailsPage.assertions.verifyBusinessInformation(userModel.businessName, userModel.businessLocation, userModel.businessType);
    //  createAccountPage.apis.deleteUser('deleteCustomerByPhone', userModel.phoneNumber);

})
