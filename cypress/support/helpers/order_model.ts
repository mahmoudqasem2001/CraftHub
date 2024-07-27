import { Address } from "./address_model"
import { DeliveryType } from "./delivery_type_model"


export class Order {
    packageType: string
    deliveryType: DeliveryType
    pickupAddress: Address
    receiverAddress: Address
    notes: string


    constructor(
        packageType: string,
        deliveryType: DeliveryType,
        pickupAddress: Address,
        receiverAddress: Address,
        notes: string
    ) {
        this.packageType = packageType;
        this.deliveryType = deliveryType;
        this.pickupAddress = pickupAddress;
        this.receiverAddress = receiverAddress;
        this.notes = notes;
    }

    static fromArray(data: [string, string][]): Order {
        const orderMap = new Map(data);

        return this.fromMap(orderMap);
    }

    static fromMap(orderMap: Map<string, string>): Order {
        return new Order(
            orderMap.get('PackageType') || '',
            DeliveryType.fromMap(orderMap),
            Address.fromMap(orderMap),
            Address.fromMap(orderMap),
            orderMap.get('Notes') || ''
        );
    }
}