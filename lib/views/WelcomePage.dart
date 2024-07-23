import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/AdminBottomBar.dart';
import 'package:grad_new_project/Views/AdminHomePage.dart';
import 'package:grad_new_project/Views/ArtistPaymentInfoCompletionPage.dart';
import 'package:grad_new_project/Views/ArtistSignUpPage.dart';
import 'package:grad_new_project/Views/CompleteAccountInfoPage.dart';
import 'package:grad_new_project/Views/ReportPage.dart';
import 'package:grad_new_project/Views/UserCompletionPage.dart';
import 'package:grad_new_project/Views/UserPaymentPage.dart';
import 'package:grad_new_project/Views/UserPersonalInfoCompletionPage.dart';
import 'package:grad_new_project/views/AccountPage.dart';
import 'package:grad_new_project/views/WebArtistDrawar.dart';
import 'package:grad_new_project/views/ArtistBottomBar.dart';
//import 'package:grad_new_project/Views/test.dart';
import 'package:grad_new_project/views/ArtistProfilePage.dart';
import 'package:grad_new_project/views/HomePage.dart';
import 'package:grad_new_project/views/SignInPage.dart';
import 'package:grad_new_project/views/UserBottomBar.dart';
import 'package:grad_new_project/views/UserSignUpPage.dart';
import 'package:grad_new_project/widgets/ArtistCurvedBottomBar.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../core/utils/router/AppColors.dart';
import '../core/utils/router/AppRouter.dart';

class WelcomePage extends StatefulWidget {
  static String routeName = '/';

  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    // //print(height.toString());
    // //print("   width  " + width.toString());

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: ResponsiveRowColumn(
            layout: !isDesktop
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            rowMainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResponsiveRowColumnItem(
                child: SizedBox(
                  height: !isDesktop ? height / 10 : 0,
                ),
              ),
              ResponsiveRowColumnItem(
                child: Image.asset(
                  'assets/images/homePage.png',
                  width: isDesktop ? width * 0.5 : width / 1.25,
                  height: isDesktop ? height * 0.7 : height / 2.1,
                ),
              ),
              ResponsiveRowColumnItem(
                child: SizedBox(height: !isDesktop ? 20 : 0),
              ),
              ResponsiveRowColumnItem(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isDesktop)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 70),
                        child: Text(
                          'Welcome',
                          style: GoogleFonts.philosopher(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  fontSize: 36)),
                        ),
                      ),
                    Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        width:
                            !isDesktop ? size.width * 0.6 : size.width * 0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: ElevatedButton(
                            onPressed: () => AppRouter.goTOScreen(
                                ArtistSignUpPage.routeName),
                            child: Text(
                              "Sign Up as an Artist",
                              style: TextStyle(color: AppColors.white),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: isDesktop ? 20 : 0)),
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(147, 116, 28, 198)),
                              overlayColor: MaterialStateProperty.all(
                                  AppColors.overlayColor),
                            ),
                          ),
                        )),
                    if (isDesktop)
                      SizedBox(
                        height: 10,
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      width: !isDesktop ? size.width * 0.6 : size.width * 0.25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: ElevatedButton(
                          onPressed: () =>
                              AppRouter.goTOScreen(UserSignUpPage.routeName),
                          child: Text(
                            "Sign Up as a User",
                            style: TextStyle(color: AppColors.white),
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: isDesktop ? 20 : 0)),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(147, 116, 28, 198)),
                            overlayColor: MaterialStateProperty.all(
                                AppColors.overlayColor),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 16.4),
                    TextButton(
                      onPressed: () =>
                          AppRouter.goTOScreenAndReplace(SignInPage.routeName),
                      child: Text(
                        'Already have an account? Sign in.',
                        style: GoogleFonts.philosopher(
                            textStyle: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              ResponsiveRowColumnItem(
                child: SizedBox(width: width / 6),
              ),
            ],
          ),
        ),
      );
    });
  }
}
