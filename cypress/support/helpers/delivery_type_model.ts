export class DeliveryType {
    type: string;
    amount: string;
    currency: string;

    constructor(
        type: string,
        amount: string,
        currency: string,
    ) {
        this.type = type,
            this.amount = amount,
            this.currency = currency
    }

    static fromArray(data: [string, string][]): DeliveryType {
        const deliveryMap = new Map(data);

        return this.fromMap(deliveryMap);
    }

    static fromMap(deliveryMap: Map<string, string>): DeliveryType {
        return new DeliveryType(
            deliveryMap.get('Type') || '',
            deliveryMap.get('Amount') || '',
            deliveryMap.get('Currency') || ''
        );
    }
}