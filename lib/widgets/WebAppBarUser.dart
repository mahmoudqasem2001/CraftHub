// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/SearchPage.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/views/AccountPage.dart';

class WebAppBarUser extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  bool withLogo;
  bool generalSearch;
  WebAppBarUser({
    Key? key,
    this.title,
    required this.withLogo,
    required this.generalSearch,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      shadowColor: AppColors.orange,
      surfaceTintColor: AppColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
      leading: withLogo
          ? Padding(
              padding: EdgeInsets.only(top: 10, left: 7, bottom: 10),
              child: Image.asset(
                'assets/images/Icon.png',
                height: 40,
              ),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: GoogleFonts.philosopher(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.brown,
                      fontSize: 16)),
            )
          : null,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            icon: Icon(
              Icons.search_sharp,
              color: AppColors.primary,
              //  size: 40,
            ),
            onPressed: () {
              AppRouter.goTOScreen(SearchPage.routeName, generalSearch);
            },
          ),
        ),
      ],
      leadingWidth: withLogo ? 160 : 40,
      foregroundColor: AppColors.brown,
      // backgroundColor: Color(0xFFf4f3f8),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
