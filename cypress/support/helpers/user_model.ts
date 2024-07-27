export class User {
    userType: string;
    profileImage: string;
    firstName: string;
    lastName: string;
    email: string;
    phoneNumber: string;
    idNumber: string;
    businessName: string;
    businessLocation: string;
    businessType: string;

    constructor(
        userType: string,
        profileImage: string,
        firstName: string,
        lastName: string,
        email: string,
        phoneNumber: string,
        idNumber: string,
        businessName: string,
        businessLocation: string,
        businessType: string
    ) {
        this.userType = userType;
        this.profileImage = profileImage;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.idNumber = idNumber;
        this.businessName = businessName;
        this.businessLocation = businessLocation;
        this.businessType = businessType;
    }

    static fromArray(data: [string, string][]): User {
        const userMap = new Map(data);

        return this.fromMap(userMap);
    }

    static fromMap(userMap: Map<string, string>): User {
        return new User(
            userMap.get('userType') || '',
            userMap.get('profileImage') || '',
            userMap.get('firstName') || '',
            userMap.get('lastName') || '',
            userMap.get('email') || '',
            userMap.get('phoneNumber') || '',
            userMap.get('idNumber') || '',
            userMap.get('businessName') || '',
            userMap.get('businessLocation') || '',
            userMap.get('businessType') || ''
        );
    }
}
