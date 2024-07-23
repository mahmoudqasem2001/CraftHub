// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/widgets/EditableTextWiedget.dart';

class EditableTextFieldWithLabel extends StatelessWidget {
  final String label;
  final String currentInfo;
  final TextEditingController controller; // for the editable text field

  const EditableTextFieldWithLabel({
    super.key,
    required this.label,
    required this.currentInfo,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightPurple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 20,
            child: Text(
              label,
              style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 17)),
            ),
          ),
          Container(
            width: 200,
            child: EditableTextWiedget(
                initialText: currentInfo,
                fontSize: 15,
                textFieldHieght: 32,
                textController: controller),
          ),
        ],
      ),
    );
  }
}
