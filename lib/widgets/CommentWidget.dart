// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/Views/AccountPage.dart';
import 'package:grad_new_project/Views/ReportPage.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';

class CommentWidget extends StatelessWidget {
  CommentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: InkWell(
            onTap: () {
              AppRouter.goTOScreen(AccountPage.routeName);
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 1),
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/Person.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: size.width * 0.76,
          // height: size.height * 0.1,
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
          margin: EdgeInsets.only(left: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.lightPurple),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Lubna Bsharat",
                    style: GoogleFonts.anta(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.overlayColor,
                            fontSize: 14)),
                  ),
                  SizedBox(
                    width: size.width * 0.33,
                  ),
                  IconButton(
                      onPressed: () {
                        AppRouter.goTOScreen(ReportPage.routeName);
                      },
                      icon: Icon(
                        Icons.report_gmailerrorred_rounded,
                        size: 20,
                        color: AppColors.grey,
                      ))
                ],
              ),
              Text(
                "good job",
                style: GoogleFonts.palanquin(
                    textStyle: TextStyle(
                        //fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                        fontSize: 14)),
              )
            ],
          ),
        )
      ],
    );
  }
}
