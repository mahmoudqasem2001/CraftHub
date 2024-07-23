// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String country;
  final String state;
  final String city;
  final String password;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.country,
    required this.state,
    required this.city,
    required this.password,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? country,
    String? state,
    String? city,
    String? password,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'country': country,
      'state': state,
      'city': city,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String,
      country: map['country'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() {
    return 'ArtistModel(firstName: $firstName, lastName: $lastName, email: $email, city: $city, password: $password, country: $country, state: $state)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.country == country &&
        other.state == state &&
        other.city == city &&
        other.password == password;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        country.hashCode ^
        state.hashCode ^
        city.hashCode ^
        password.hashCode;
  }
}
