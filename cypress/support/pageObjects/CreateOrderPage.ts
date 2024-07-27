import { Address } from "../helpers/address_model";
import { Order } from "../helpers/order_model";

export default class CreateOrderPage {
    URLs = {
        page: '/create-order',
    }

    elements = {
        submitOrderButton: () => cy.getDataTest('submit-order-button'),

        packagingType: {
            //---------------Packaging Section------------------/
            packageTypesContainer: () => cy.getDataTest('package-types-container'),
            packageTypesDropdown: () => cy.getDataTest('package-types-dropdown'),
            packageTypesDropdownMenu: () => cy.getDataTest('package-types-dropdown-menu'),
            packageHeightInput: () => cy.getDataTest('package-height'),
            packageWidthInput: () => cy.getDataTest('package-width'),
            packageLengthInput: () => cy.getDataTest('package-length'),
            packageWeightInput: () => cy.getDataTest('package-weight'),
        },
        deliveryType: {
            //---------------Delivery Section--------------------/
            deliveryTypesContainer: () => cy.getDataTest('delivery-type-container'),
            deliveryTypesRadio: () => cy.getDataTest('radio'),
            deliveryTypeWithCash: () => cy.getDataTest('radio-cash-delivery'),
            deliveryTypeWithoutCash: () => cy.getDataTest('radio-delivery'),
            cashAmountInput: () => cy.getDataTest('amount-input'),
            currencyTypeDropdown: () => cy.getDataTest('currency-type-dropdown'),
        },

        pickupAddress: {
            //--------------Pickup Address Section---------------/
            pickupAddressContainer: () => cy.getDataTest('pickup-address-container'),
            pickupAddressName: () => cy.getDataTest('name-input'),
            changePickupAddressModal: () => cy.getDataTest('change-pickup-address-model'),
            pickedUpAddress: () => cy.getDataTest('pickedUp-address-input'),
            pickedUpAddressMobileNumber: () => cy.getDataTest('mobile-number-input'),
            pickupAddressButton: () => cy.getDataTest('pickup-address-button'),
            createAddressButton: () => cy.getDataTest('create-address-button'),
            setDefaultButton: () => cy.getDataTest('set-default-button'),
            setOnlyNowDefaultButton: () => cy.getDataTest('set-only-now-default-button'),
            nameSearchInput: () => cy.getDataTest('address-name-search-input'),
            mobileNumberSearchInput: () => cy.getDataTest('mobile-number-search-input'),
            pickupAddressTable: () => cy.getDataTest('pickup-addresses-table'),
            closeChangePickupAddressModalButton: () => cy.get('button.btn-close[aria-label="Close"]'), //should added into frontend
            // closeAddPickupAddressModalButton: () => cy.getDataTest('close-add-pickup-address-button'), //should added into frontend
            modalTitle: () => cy.getDataTest('modal-title'),
            nameInput: () => cy.getDataTest('placename-input'),
            phoneInput: () => cy.getDataTest('phone-input'),
            provinceDropdown: () => cy.getDataTest('province-select'),
            governorateDropdown: () => cy.getDataTest('governorate-select'),
            cityDropdown: () => cy.getDataTest('city-select'),
            areaDropdown: () => cy.getDataTest('area-select'),
            addressInput: () => cy.getDataTest('address-input'),
            addressInformationInput: () => cy.getDataTest('address-info-input'),
            addressSharedSwitch: () => cy.getDataTest('address-shared-switch'),
            proceedNewAddressBtn: () => cy.getDataTest('submit-button'),
        },
        receiverAddress: {
            //--------------Receiver Address Section---------------/
            receiverAddressContainer: () => cy.getDataTest('receiver-address-container'),
            receiverAddressNameInput: () => cy.getDataTest('receiver-name-input'),
            receiverPhoneInput: () => cy.getDataTest('receiver-phone-input'),
            receiverProvinceDropdown: () => cy.getDataTest('receiver-province-dropdown'),
            receiverGovernorateDropdown: () => cy.getDataTest('receiver-governorate-dropdown'),
            receiverCityDropdown: () => cy.getDataTest('receiver-city-dropdown'),
            receiverAreaDropdown: () => cy.getDataTest('receiver-area-dropdown'),
            receiverAddressInput: () => cy.getDataTest('receiver-address-input'),
            receiverAddressInformationInput: () => cy.getDataTest('receiver-address-info-input'),
            changeReceiverAddressButton: () => cy.getDataTest('change-receiver-address-button'),
            selectReceiverAddressButton: () => cy.getDataTest('select-receiver-address-button'),
        },
        attachments: {
            //------------Attachments Section-----------------------/
            attachmentsContainer: () => cy.getDataTest('attachments-container'),
            newOrderNotesInput: () => cy.getDataTest('new-order-notes-input'),
        },
        errors: {
            //----------------Errors--------------------------------/
            requiredErrorContainer: () => cy.getDataTest('required-error-container'),
        },

    }

    actions = {
        packagingType: {

            //---------------Packaging Section------------------/
            selectPackagingType: (index: string, packagingType: string) => {
                const idx = parseInt(index, 10);
                this.elements.packagingType.packageTypesDropdown().click();
                this.elements.packagingType.packageTypesDropdownMenu().children('a').eq(idx).click();
            },
        },
        deliveryType: {

            //---------------Delivery Section--------------------/
            selectDeliveryType: (index: string, deliveryType: string) => {
                const idx = parseInt(index, 10);
                this.elements.deliveryType.deliveryTypesContainer().get(`.toggleButtonsContainer > :nth-child(${index})`).click();
            },

            setCashAmount: (amount: string, index: string) => {
                this.elements.deliveryType.cashAmountInput().clear().type(amount);
                this.elements.deliveryType.currencyTypeDropdown().select(index);
            },
        },
        pickupAddress: {

            //--------------Pickup Address Section---------------/
            clickChangePickupAddressButton: () => {
                this.elements.pickupAddress.pickupAddressButton().click();
            },


            clickAddPickupAddressButton: () => {
                this.elements.pickupAddress.createAddressButton().click();
            },

            fillAddress: (addressModel: Address) => {
                this.elements.pickupAddress.nameInput().type(addressModel.name);
                this.elements.pickupAddress.phoneInput().type(addressModel.phoneNumber);
                this.elements.pickupAddress.provinceDropdown().select(0);
                this.elements.pickupAddress.provinceDropdown().select(addressModel.province);
                this.elements.pickupAddress.governorateDropdown().select(addressModel.governorate);
                this.elements.pickupAddress.cityDropdown().select(addressModel.city);
                this.elements.pickupAddress.areaDropdown().select(addressModel.area);
                this.elements.pickupAddress.addressInput().type(addressModel.address);
                this.elements.pickupAddress.addressInformationInput().type(addressModel.additionalInfo);
            },
            clickProceedAddressButton: () => {
                this.elements.pickupAddress.proceedNewAddressBtn().click();
            },

            clickSetDefaultAddressButton: (index: string) => {
                const idx = parseInt(index, 10);
                this.elements.pickupAddress.setDefaultButton().eq(idx).click();
                this.elements.pickupAddress.closeChangePickupAddressModalButton().click();
            },

            searchAddress: (addressModel: Address) => {
                this.elements.pickupAddress.nameSearchInput().type(addressModel.name);
                this.elements.pickupAddress.mobileNumberSearchInput().type(addressModel.phoneNumber);
            },
        },
        receiverAddress: {

            //--------------Receiver Address Section---------------/
            chooseReceiverAddressButton: () => {
                this.elements.receiverAddress.changeReceiverAddressButton().click();
            },
            clickSelectReceiverAddressButton: (addressModel: Address) => {
                cy.get('[data-test=tbody]').within(() => {
                    cy.get('td').eq(0).contains(addressModel.name)
                        .next()
                        .contains(addressModel.address + ', ' + addressModel.city)
                        .next()
                        .contains(addressModel.phoneNumber)
                        .next().click();
                });
                //  this.elements.selectReceiverAddressButton().first()
            },
        },
        //--------------Submit Order Section---------------------/
        clickSubmitOrderButton: () => {
            this.elements.submitOrderButton().click();
        },
        fillOrderInfo: (orderModel: Order) => {
            this.elements.deliveryType.cashAmountInput().type(orderModel.deliveryType.amount);
            this.actions.receiverAddress.chooseReceiverAddressButton();
            this.actions.receiverAddress.clickSelectReceiverAddressButton(orderModel.receiverAddress)
        },

        fillPhoneNumberInput: (phoneNumber: string) => {
            this.elements.receiverAddress.receiverPhoneInput().type(phoneNumber);
        }



    }
    assertions = {
        packagingType: {

            //---------------Packaging Section------------------/
            verifySelectingPackagingType: (packageType: string) => {
                cy.get('a[aria-selected="true"]').should('contain.text', packageType);
                if (packageType == 'Medium Package' || packageType == 'Large Package') {
                    this.elements.packagingType.packageHeightInput().should('be.visible');
                    this.elements.packagingType.packageWidthInput().should('be.visible');
                    this.elements.packagingType.packageLengthInput().should('be.visible');
                    this.elements.packagingType.packageWeightInput().should('be.visible');
                }
            },
        },
        deliveryType: {

            //---------------Delivery Section--------------------/
            verifySelectingDeliveryType: (index: string, deliveryType: string) => {
                const idx = parseInt(index, 10);
                this.elements.deliveryType.deliveryTypesRadio().eq(idx - 1).should('have.class', 'active');
                if (deliveryType == 'Cash on Delivery') {
                    this.elements.deliveryType.cashAmountInput().should('be.visible');
                    this.elements.deliveryType.currencyTypeDropdown().should('be.visible');
                }
            },
        },
        pickupAddress: {

            //--------------Pickup Address Section---------------/
            verifyPickupAddress: (addressModel: Address) => {
                this.elements.pickupAddress.pickupAddressTable().find('tr').contains(addressModel.address + ', ' + addressModel.city).last().parent().within(() => {
                    cy.get('td').eq(0).should('have.text', addressModel.name);

                    cy.get('td').eq(1).should('have.text', addressModel.address + ', ' + addressModel.city);

                    cy.get('td').eq(2).should('have.text', addressModel.phoneNumber);

                    cy.get('td').eq(3).find('button').first()
                        .should('have.text', 'Set Default')
                    cy.get('td').eq(3).find('button').last()
                        .should('have.text', 'Set Only for Now')
                });
            },

            verifyDefaultPickupAddress: (address: string) => {
                this.elements.pickupAddress.pickedUpAddress().should('be.visible').should('have.attr', 'placeholder', address);
            },

            verifySearchAddress: (addressModel: Address) => {
                this.elements.pickupAddress.nameSearchInput().should('have.value', addressModel.name);
                this.elements.pickupAddress.mobileNumberSearchInput().should('have.value', addressModel.phoneNumber);

                this.elements.pickupAddress.pickupAddressTable().should('contain.text', addressModel.name);
                this.elements.pickupAddress.pickupAddressTable().should('contain.text', addressModel.phoneNumber);
            },
        },
        receiverAddress: {

            //--------------Receiver Address Section---------------/
            verifyReceiverAddressChanged: (address: Address) => {
                this.elements.receiverAddress.receiverAddressContainer().within(() => {
                    this.elements.receiverAddress.receiverAddressNameInput().should('have.attr', 'placeholder', address.name);
                    this.elements.receiverAddress.receiverPhoneInput().should('have.attr', 'placeholder', address.phoneNumber);
                    this.elements.receiverAddress.receiverProvinceDropdown().eq(0).should('have.value', address.province);
                    this.elements.receiverAddress.receiverGovernorateDropdown().eq(0).should('have.value', address.governorate);
                    this.elements.receiverAddress.receiverCityDropdown().eq(0).should('have.value', address.city);
                    this.elements.receiverAddress.receiverAreaDropdown().eq(0).should('have.value', address.area);
                    this.elements.receiverAddress.receiverAddressInput().should('have.attr', 'placeholder', address.address);
                    this.elements.receiverAddress.receiverAddressInformationInput().should('have.attr', 'placeholder', address.additionalInfo);
                });
            },
        },
        //--------------Submit Order Section---------------------/
        verifyRequiredFieldShown: () => {
            this.elements.errors.requiredErrorContainer().within(() => {
                cy.get('span').should('contain', 'Some fields are required!')
            })
        },

        verifyOrderCreated: () => {
            cy.url().should('contain', 'https://dev.togo.ps/account/Order/');
            cy.get('.card-body').should('exist').should('be.visible');
        },

        verifyInvalidPhoneNumberShown: () => {
            this.elements.receiverAddress.receiverAddressContainer().within(() => {
                cy.get('.invalid-feedback').should('contain', 'Please enter a valid phone number example 0568000000');
            })
        }

    }


}