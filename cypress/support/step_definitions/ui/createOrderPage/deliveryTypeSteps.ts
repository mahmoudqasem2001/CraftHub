
import { DataTable, Given, Then, When } from '@badeball/cypress-cucumber-preprocessor';
import CreateOrderPage from '../../../pageObjects/CreateOrderPage';

const createOrderPage = new CreateOrderPage();

When('User selects Delivery Type index as {string} and type as {string}', (index: string, type: string) => {
    createOrderPage.actions.deliveryType.selectDeliveryType(index, type);
});
When('User enters amount and selects currency type if cash delivery', (dataTable: DataTable) => {
    const data = dataTable.rowsHash();
    createOrderPage.actions.deliveryType.setCashAmount(data.amount, data.currencyIndex);
});
Then('User should see the correct delivery type selected as {string} at {string}', (type: string, index: string) => {
    createOrderPage.assertions.deliveryType.verifySelectingDeliveryType(index, type);
});
