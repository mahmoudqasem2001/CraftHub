// profile_model.dart
import 'dart:convert';

class Profile {
  final String gender;
  final String birthOfDate;
  final String projectName;
  final String image;
  final dynamic interestedCategories;
  String? categoryName;

  Profile({
    required this.gender,
    required this.birthOfDate,
    required this.projectName,
    required this.image,
    required this.interestedCategories,
    this.categoryName,
  });

  Profile copyWith({
    String? gender,
    String? birthOfDate,
    String? projectName,
    String? image,
    dynamic interestedCategories,
  }) {
    return Profile(
      gender: gender ?? this.gender,
      birthOfDate: birthOfDate ?? this.birthOfDate,
      projectName: projectName ?? this.projectName,
      image: image ?? this.image,
      interestedCategories: interestedCategories ?? this.interestedCategories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'birth_of_date': birthOfDate,
      'project_name': projectName,
      'image': image,
      'interested_categories': interestedCategories,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      gender: map['gender'] as String,
      birthOfDate: map['birth_of_date'] as String,
      projectName: map['project_name'] as String,
      image: map['image'] as String,
      interestedCategories: map['interested_categories'],
      categoryName: map['category_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(gender: $gender, birthOfDate: $birthOfDate, projectName: $projectName, image: $image, interestedCategories: $interestedCategories)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.gender == gender &&
        other.birthOfDate == birthOfDate &&
        other.projectName == projectName &&
        other.image == image &&
        other.interestedCategories == interestedCategories;
  }

  @override
  int get hashCode {
    return gender.hashCode ^
        birthOfDate.hashCode ^
        projectName.hashCode ^
        image.hashCode ^
        interestedCategories.hashCode;
  }
}
