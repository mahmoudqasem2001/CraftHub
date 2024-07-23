import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/AccountCompletionPage.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:responsive_framework/responsive_row_column.dart';

class CompleteAccountInfoPage extends StatelessWidget {
  static String routeName = "complete-account-info";
  const CompleteAccountInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Scaffold(
        body: Center(
          child: ResponsiveRowColumn(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            layout: !isDesktop
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            rowMainAxisAlignment: MainAxisAlignment.start,
            columnCrossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ResponsiveRowColumnItem(
                child: Image.asset(
                  "assets/images/CompleteAccountInfo.jpg",
                  width: !isDesktop ? size.width * 0.6 : size.width * 0.65,
                  height: !isDesktop ? size.height / 1.9 : size.height * 0.8,
                ),
              ),
              if (isDesktop)
                ResponsiveRowColumnItem(
                    child: SizedBox(
                  width: 30,
                )),
              ResponsiveRowColumnItem(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Only Two Steps to \nComplete Your Account',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.imFellDoublePica(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: !isDesktop ? 22 : 30)),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: Container(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              AppRouter.goTOScreenAndReplace(
                                  AccountCompletionPage.routeName);
                            },
                            child: Text(
                              "Complete Your Info NOW!",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: !isDesktop ? 12 : 17),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: !isDesktop ? 35 : 60,
                                    vertical: 2),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                AppColors.primary,
                              ),
                              overlayColor: MaterialStateProperty.all(
                                AppColors.overlayColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              /*SizedBox(
                  height: size.height * 0.2,
                ),*/
              /*  Dismissible(
                  direction: DismissDirection.horizontal,
                  onDismissed: (_) {
                    AppRouter.goTOScreenAndReplace(AccountPage.routeName);
                  },
                  key: UniqueKey(),
                  child: Column(
                    children: [
                      Text(
                        "Swipe Up",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.imFellDoublePica(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.orange2,
                                fontSize: 20)),
                      ),
                      Image.asset(
                        "assets/images/Arrow.png",
                        width: 40,
                        height: 40,
                      )
                    ],
                  ),
                )*/
            ],
          ),
        ),
      );
    });
  }
}
