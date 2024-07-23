// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ArtistProfileModel {
  int artistId;
  String artistName;
  String ProjectName;
  ArtistProfileModel({
    required this.artistId,
    required this.artistName,
    required this.ProjectName,
  });

  ArtistProfileModel copyWith({
    int? artistId,
    String? artistName,
    String? ProjectName,
  }) {
    return ArtistProfileModel(
      artistId: artistId ?? this.artistId,
      artistName: artistName ?? this.artistName,
      ProjectName: ProjectName ?? this.ProjectName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'artist_id': artistId,
      'artist': artistName,
      'Project_name': ProjectName,
    };
  }

  factory ArtistProfileModel.fromMap(Map<String, dynamic> map) {
    return ArtistProfileModel(
      artistId: map['artist_id'] as int,
      artistName: map['artist'] as String,
      ProjectName: map['project_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArtistProfileModel.fromJson(String source) =>
      ArtistProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ArtistProfileModel(artistId: $artistId, artistName: $artistName, ProjectName: $ProjectName)';

  @override
  bool operator ==(covariant ArtistProfileModel other) {
    if (identical(this, other)) return true;

    return other.artistId == artistId &&
        other.artistName == artistName &&
        other.ProjectName == ProjectName;
  }

  @override
  int get hashCode =>
      artistId.hashCode ^ artistName.hashCode ^ ProjectName.hashCode;
}
