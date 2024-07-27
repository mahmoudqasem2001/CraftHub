import { Given, Then, When } from '@badeball/cypress-cucumber-preprocessor';
import CreateOrderPage from '../../../pageObjects/CreateOrderPage';
const createOrderPage = new CreateOrderPage();

When('User selects Packaging Type index as {string} and type as {string}', (index: string, type: string) => {
    createOrderPage.actions.packagingType.selectPackagingType(index, type);
});
Then('User should see the correct packaging type selected as {string}', (type: string) => {
    createOrderPage.assertions.packagingType.verifySelectingPackagingType(type);
});
