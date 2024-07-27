import { DataTable, Given, Then, When } from '@badeball/cypress-cucumber-preprocessor';
import CreateOrderPage from '../../../pageObjects/CreateOrderPage';
import { Address } from '../../../helpers/address_model';
import { DeliveryType } from '../../../helpers/delivery_type_model';
import { Order } from '../../../helpers/order_model';

const createOrderPage = new CreateOrderPage();

Given('User is on the create order page', () => {
    cy.login('0599344870');
    cy.visit('/account/main' + createOrderPage.URLs.page);
});



When('User clicks on the submit order button', () => {
    createOrderPage.actions.clickSubmitOrderButton();
});

Then('An error should appear for filling in required fields', () => {
    createOrderPage.assertions.verifyRequiredFieldShown();
});

When('User Fills all order information', (dataTable: DataTable) => {
    const orderData = dataTable.rows().map(row => [row[0], row[1]] as [string, string]);
    const orderModel: Order = Order.fromArray(orderData);
    createOrderPage.actions.fillOrderInfo(orderModel);
});

Then('A new order should be created with the following information and navigate into order page', () => {
    createOrderPage.assertions.verifyOrderCreated();
});

When('User fills phone number as {string} fields with invalid input data', (phoneNumber: string) => {
    createOrderPage.actions.fillPhoneNumberInput(phoneNumber);

});

Then('An error should appear for filling the valid data in input field', () => {
    createOrderPage.assertions.verifyInvalidPhoneNumberShown();
});
