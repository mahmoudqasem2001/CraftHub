import { Then, When } from "@badeball/cypress-cucumber-preprocessor";
import { CreateAccountPage } from "../../../pageObjects/CreateAccountPage";

const createAccountPage = new CreateAccountPage();

When('User clicks on "Already have an account?"', () => {
    createAccountPage.actions.clickAlreadyHaveAccount();
});

Then('User should be redirected to the login page', () => {
    createAccountPage.assertions.verifyNavigationToLogin();
});
