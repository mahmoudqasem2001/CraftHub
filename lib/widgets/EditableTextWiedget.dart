// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';

class EditableTextWiedget extends StatefulWidget {
  final String initialText;
  final double fontSize;
  final double textFieldHieght;
  final TextEditingController textController;
  EditableTextWiedget({
    Key? key,
    required this.initialText,
    required this.fontSize,
    required this.textFieldHieght,
    required this.textController,
  }) : super(key: key);

  @override
  State<EditableTextWiedget> createState() => _EditableTextWiedgetStateState();
}

class _EditableTextWiedgetStateState extends State<EditableTextWiedget> {
  bool _isEditing = false;
  String _text = "";

  @override
  void initState() {
    super.initState();
    _text = widget.initialText;

    widget.textController.text = _text; // Initialize controller text
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: widget.textFieldHieght,
      child: TextField(
        controller: widget.textController,
        readOnly: !_isEditing,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none, // Remove border for normal text appearance
        ),
        onTap: () {
          setState(() {
            _isEditing = true;
            // Set cursor and selection on entering edit mode
            widget.textController.selection =
                TextSelection.collapsed(offset: _text.length);
          });
        },
        style: GoogleFonts.philosopher(
            textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.darkBrown,
                fontSize: widget.fontSize)),
        maxLines: null,
        onChanged: (value) => setState(() => _text = value),
      ),
    );
  }
}
