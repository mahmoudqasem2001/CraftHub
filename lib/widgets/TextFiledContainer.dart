// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';

class TextFiledContainer extends StatelessWidget {
  final Widget child;
  final double widthFactor;
  final double heightFactor;
  final double borderRadius;
  const TextFiledContainer({
    Key? key,
    required this.child,
    required this.widthFactor,
    required this.heightFactor,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          width: size.width * widthFactor,
          height: size.height * heightFactor,
          decoration: BoxDecoration(
            color: AppColors.lightPurple,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
      ],
    );
  }
}
