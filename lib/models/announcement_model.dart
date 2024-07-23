// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AnnouncementModel {
  final String id;
  final String imgUrl;

  AnnouncementModel({required this.id, required this.imgUrl});

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      id: map['id'] as String,
      imgUrl: map['imgUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imgUrl': imgUrl,
    };
  }

  String toJson() => json.encode(toMap());

  factory AnnouncementModel.fromJson(String source) =>
      AnnouncementModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<AnnouncementModel> dummyAnnouncements = [
  AnnouncementModel(
    id: '1',
    imgUrl:
        'https://marketplace.canva.com/EAFMdLQAxDU/1/0/1600w/canva-white-and-gray-modern-real-estate-modern-home-banner-NpQukS8X1oo.jpg',
  ),
  AnnouncementModel(
    id: '2',
    imgUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSES1DJZTasRdYpVhlBLsC9CTksUhlWciIxCF7ZsLpKKppIX__tpZW4YQ_KNH6XF-ZIbhU&usqp=CAU',
  ),
  AnnouncementModel(
    id: '3',
    imgUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSES1DJZTasRdYpVhlBLsC9CTksUhlWciIxCF7ZsLpKKppIX__tpZW4YQ_KNH6XF-ZIbhU&usqp=CAU',
  ),
  AnnouncementModel(
    id: '4',
    imgUrl:
        'https://cloudinary.hbs.edu/hbsit/image/upload/s--EmT0lNtW--/f_auto,c_fill,h_375,w_750,/v20200101/6978C1C20B650473DD135E5352D37D55.jpg',
  ),
];
