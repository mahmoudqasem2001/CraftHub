import 'dart:convert';

class ArtistModel {
  final String firstName;
  final String lastName;
  final String email;
  final String city;
  final String projectName;
  final String password;
  final String country;
  final String state;

  ArtistModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
    required this.projectName,
    required this.password,
    required this.country,
    required this.state,
  });

  ArtistModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? city,
    String? projectName,
    String? password,
    String? country,
    String? state,
  }) {
    return ArtistModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      city: city ?? this.city,
      projectName: projectName ?? this.projectName,
      password: password ?? this.password,
      country: country ?? this.country,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'city': city,
      'project_name': projectName,
      'password': password,
      'country': country, // Add to map
      'state': state, // Add to map
    };
  }

  factory ArtistModel.fromMap(Map<String, dynamic> map) {
    return ArtistModel(
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String,
      city: map['city'] as String,
      projectName: map['project_name'] as String,
      password: map['password'] as String,
      country: map['country'] as String,
      state: map['state'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArtistModel.fromJson(String source) =>
      ArtistModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ArtistModel(firstName: $firstName, lastName: $lastName, email: $email, city: $city, projectName: $projectName, password: $password, country: $country, state: $state)';
  }

  @override
  bool operator ==(covariant ArtistModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.city == city &&
        other.projectName == projectName &&
        other.password == password &&
        other.country == country &&
        other.state == state;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        city.hashCode ^
        country.hashCode ^
        state.hashCode ^
        projectName.hashCode ^
        password.hashCode;
  }
}
