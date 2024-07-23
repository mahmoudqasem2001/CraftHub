// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ErrorMessageModel {
  final String detail;
  final String code;
  const ErrorMessageModel({
    required this.detail,
    this.code = '401',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'detail': detail,
      'code': code,
    };
  }

  factory ErrorMessageModel.fromMap(Map<String, dynamic> map) {
    return ErrorMessageModel(
      detail: map['detail'] as String,
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorMessageModel.fromJson(String source) =>
      ErrorMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
