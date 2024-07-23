// account_model.dart
import 'dart:convert';
import 'profile_model.dart';

class AccountModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String country;
  final String state;
  final String city;
  final Profile profile;
  final int followersCount;

  AccountModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.country,
    required this.state,
    required this.city,
    required this.profile,
    required this.followersCount,
  });

  AccountModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? country,
    String? state,
    String? city,
    Profile? profile,
    int? followersCount,
  }) {
    return AccountModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      profile: profile ?? this.profile,
      followersCount: followersCount ?? this.followersCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'country': country,
      'state': state,
      'city': city,
      'profile': profile.toMap(),
      'followers_count': followersCount,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'] as int,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String,
      country: map['country'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      profile:
          // Profile.fromMap(map['profile'] as Map<String, dynamic> ),
          Profile(
              gender: map['profile']['gender'],
              birthOfDate: map['profile']['birth_of_date'],
              projectName: map['profile']['project_name'].toString(),
              image: map['profile']['image'],
              interestedCategories: map['profile']['interested_categories'],
              categoryName: map['profile']['category_name'].toString()),
      followersCount: map['followers_count'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccountModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, country: $country, state: $state, city: $city, profile: $profile, followersCount: $followersCount)'; // Include new attribute
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountModel &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.country == country &&
        other.state == state &&
        other.city == city &&
        other.profile == profile &&
        other.followersCount == followersCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        country.hashCode ^
        state.hashCode ^
        city.hashCode ^
        profile.hashCode ^
        followersCount.hashCode;
  }
}
