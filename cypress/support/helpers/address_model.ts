export class Address {
    name: string;
    phoneNumber: string;
    province: string;
    governorate: string;
    city: string;
    area: string;
    address: string;
    additionalInfo: string;

    constructor(
        name: string,
        phoneNumber: string,
        province: string,
        governorate: string,
        city: string,
        area: string,
        address: string,
        additionalInfo: string
    ) {
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.province = province;
        this.governorate = governorate;
        this.city = city;
        this.area = area;
        this.address = address;
        this.additionalInfo = additionalInfo;
    }
    static fromArray(data: [string, string][]): Address {
        const addressMap = new Map(data);

        return this.fromMap(addressMap);
    }

    static fromMap(addressMap: Map<string, string>): Address {
        return new Address(
            addressMap.get('Name') || '',
            addressMap.get('PhoneNumber') || '',
            addressMap.get('Province') || '',
            addressMap.get('Governorate') || '',
            addressMap.get('City') || '',
            addressMap.get('Area') || '',
            addressMap.get('Address') || '',
            addressMap.get('AdditionalInfo') || ''
        );
    }

}
