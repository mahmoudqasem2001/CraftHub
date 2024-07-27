
import { DataTable, Given, Then, When } from '@badeball/cypress-cucumber-preprocessor';
import CreateOrderPage from '../../../pageObjects/CreateOrderPage';
import { Address } from '../../../helpers/address_model';

const createOrderPage = new CreateOrderPage();

When('User clicks on change pickup address button', () => {
    createOrderPage.actions.pickupAddress.clickChangePickupAddressButton();
});

When('User clicks on add pickup address button', () => {
    createOrderPage.actions.pickupAddress.clickAddPickupAddressButton();
});
When('User Fills all address information', (dataTable: DataTable) => {
    const addressData = dataTable.rows().map(row => [row[0], row[1]] as [string, string]);
    const addressModel: Address = Address.fromArray(addressData);
    createOrderPage.actions.pickupAddress.fillAddress(addressModel);
});
When('User clicks on the proceed button', () => {
    createOrderPage.actions.pickupAddress.clickProceedAddressButton();

});
Then('A new pickup address should be added to the addresses list', (dataTable: DataTable) => {
    const addressData = dataTable.rows().map(row => [row[0], row[1]] as [string, string]);
    const addressModel: Address = Address.fromArray(addressData);
    createOrderPage.assertions.pickupAddress.verifyPickupAddress(addressModel);
});


When('User clicks on the set default pickup address button at {string} index', (index: string) => {
    createOrderPage.actions.pickupAddress.clickSetDefaultAddressButton(index);
});
Then('The default pickup address should be set to the selected address as {string}', (address: string) => {
    createOrderPage.assertions.pickupAddress.verifyDefaultPickupAddress(address);
});



When('User Search for a specific address by {string} and {string}', (name: string, mobileNumber: string) => {
    const addressMap = new Map();
    addressMap.set('Name', name);
    addressMap.set('PhoneNumber', mobileNumber);
    const addressModel = Address.fromMap(addressMap);
    createOrderPage.actions.pickupAddress.searchAddress(addressModel);
});
Then('Pickup addresses should be filtered as {string} and {string}', (name: string, mobileNumber: string) => {
    const addressMap = new Map();
    addressMap.set('Name', name);
    addressMap.set('PhoneNumber', mobileNumber);
    const addressModel = Address.fromMap(addressMap);
    createOrderPage.assertions.pickupAddress.verifySearchAddress(addressModel);
});
