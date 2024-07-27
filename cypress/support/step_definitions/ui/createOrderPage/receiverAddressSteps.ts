import { DataTable, Given, Then, When } from '@badeball/cypress-cucumber-preprocessor';
import CreateOrderPage from '../../../pageObjects/CreateOrderPage';
import { Address } from '../../../helpers/address_model';

const createOrderPage = new CreateOrderPage();


When('User clicks on choose from my list button', () => {
    createOrderPage.actions.receiverAddress.chooseReceiverAddressButton();
});

When('User Click on the select button for the in the addresses list', (dataTable: DataTable) => {
    const addressData = dataTable.rows().map(row => [row[0], row[1]] as [string, string]);
    const addressModel: Address = Address.fromArray(addressData);
    createOrderPage.actions.receiverAddress.clickSelectReceiverAddressButton(addressModel);
});

Then('The receiver address should be changed correctly', (dataTable: DataTable) => {
    const addressData = dataTable.rows().map(row => [row[0], row[1]] as [string, string]);
    const addressModel: Address = Address.fromArray(addressData);
    createOrderPage.assertions.receiverAddress.verifyReceiverAddressChanged(addressModel);
});