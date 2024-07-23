// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';

class TextContainerWithArrowButton extends StatelessWidget {
  double height;
  String text;
  //onPressed(double heightFactor, Widget onPressedChild);
  final void Function() onPressed;
  TextEditingController infoController = TextEditingController();
/*void _handlePress() {
    onPressed(42.0, Text('Example Widget'));
  }*/
  TextContainerWithArrowButton(
      {Key? key,
      required this.height,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height: height,
        color: AppColors.lightPurple,
        child: TextFormField(
            readOnly: true,
            controller: infoController,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightPurple2),
              ),
              hintText: text,
              hintStyle: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                      fontSize: 15)),
              suffixIcon: IconButton(
                onPressed: () async {},
                icon: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: AppColors.brown,
                    size: 20,
                  ),
                  onPressed: onPressed,
                ),
              ),
            ))

        /* Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'lubna@outlook.com',
                style: GoogleFonts.anta(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(113, 75, 43, 32),
                        fontSize: 13)),
              ),
            ),
          ],
        ));*/
        );
  }
}
