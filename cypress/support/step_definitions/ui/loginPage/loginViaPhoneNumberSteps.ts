import { Given, When, Then, DataTable } from '@badeball/cypress-cucumber-preprocessor';
import { LoginPage } from '../../../pageObjects/LoginPage';

const loginPage = new LoginPage();

Given('User goes to login via phone number', () => {
    loginPage.actions.navigateToLoginPage();
});

When('User Fills his phone number on input field', (dataTable: DataTable) => {
    const data = dataTable.rowsHash();
    loginPage.actions.fillPhoneNumber(data.phoneNumber);
});

When('User clicks on send button', () => {
    loginPage.actions.clickSendButton();
});

When('User enters OTP code on OTP input field', (dataTable: DataTable) => {
    const data = dataTable.rowsHash();
    loginPage.actions.fillOtpCode(data.otpCode);
});

When('User clicks on login button', () => {
    loginPage.actions.clickLoginButton();
});

Then('User should be login successfully and redirected to homepage', () => {
    loginPage.assertions.verifySuccessfulLogin();
});

Then('Popup alert should shown with error message', (dataTable: DataTable) => {
    const data = dataTable.rowsHash();
    loginPage.assertions.verifyAlertPopup(data.message);
});

Then('An error message for {string} should shown with {string} message', (errorFor: string, message: string) => {
    loginPage.assertions.verifyErrorMessageForField(errorFor, message);
});
