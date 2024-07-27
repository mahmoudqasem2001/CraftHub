import { Given, Then, When } from "@badeball/cypress-cucumber-preprocessor";
import { CreateAccountPage } from "../../../pageObjects/CreateAccountPage";

const createAccountPage = new CreateAccountPage();

Then('User should see an error message in the modal field', () => {
    createAccountPage.assertions.verifyModalErrorMessageVisible();
});

When('User fills firstName as {string}, and lastName as {string}', (firstName: string, lastName: string) => {
    createAccountPage.actions.fillUserName(firstName, lastName);
});

When('User fills invalid email as {string}', (email: string) => {
    createAccountPage.actions.fillUserEmail(email);
});

Then('User should see an error message as {string}', (message: string) => {
    createAccountPage.assertions.verifyEmailErrorMessageShown(message);
});
