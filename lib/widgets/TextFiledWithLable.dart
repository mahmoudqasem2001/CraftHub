// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/widgets/TextFiledContainer.dart';

class TextFiledWithLabel extends StatefulWidget {
  //final Widget child;
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final double widthFactor;
  final double heightFactor;
  final double borderRadius;
  final String? Function(String?)? validator;
  final Widget? Icon;
  const TextFiledWithLabel({
    Key? key,
    //required this.child,
    required this.controller,
    required this.obscureText,
    required this.label,
    required this.widthFactor,
    required this.heightFactor,
    required this.borderRadius,
    this.Icon,
    required this.validator,
  }) : super(key: key);

  @override
  State<TextFiledWithLabel> createState() => _TextFiledWithLabelState();
}

class _TextFiledWithLabelState extends State<TextFiledWithLabel> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("      " + widget.label,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(200, 141, 87, 193)),
            )),
        SizedBox(
          // height: 5,
          width: 5,
        ),
        TextFiledContainer(
            widthFactor: widget.widthFactor,
            heightFactor: widget.heightFactor,
            borderRadius: widget.borderRadius,
            child: TextFormField(
              //textAlignVertical: TextAlignVertical.top,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: Color.fromARGB(201, 111, 53, 165),
                    fontWeight: FontWeight.bold),
              ),
              obscureText: widget.obscureText,
              controller: widget.controller,
              validator: (value) {
                setState(() {
                  _errorText = widget.validator!(value);
                });
                return null;
              },
              decoration: InputDecoration(
                hintText: widget.label,
                hintStyle: TextStyle(
                  color: Color.fromRGBO(111, 53, 165, 0.341),
                  fontSize: 14.1,
                ),
                icon: widget.Icon,
                border: InputBorder.none,
              ),
            )),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              _errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
