// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';

class DropDownList extends StatefulWidget {
  DropDownList(
      {Key? key,
      this.selectedGender,
      required this.dropdownItems,
      required this.width,
      required this.hintText})
      : super(key: key);

  final List<DropdownMenuItem<String>> dropdownItems;
  final double width;
  final String hintText;
  String? selectedGender;
  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: widget.width,
      height: size.height * 0.08,
      child: DropdownButtonFormField<String>(
        alignment: AlignmentDirectional.topStart,
        isExpanded: true,
        menuMaxHeight: size.height * 0.5,
        hint: Text(
          this.widget.hintText,
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(169, 75, 43, 32),
                  fontSize: 14)),
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        dropdownColor: Color.fromARGB(255, 243, 239, 249),
        value: null,
        items: widget.dropdownItems,
        onChanged: (String? value) {
          if (value == 'Female') {
            setState(() {
              widget.selectedGender = '1';
            });
          } else if (value == 'Male') {
            setState(() {
              widget.selectedGender = '0';
            });
          }
        },
        //itemHeight: 40,
        focusColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
