// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/views/AccountPage.dart';

class WebAppBar extends StatelessWidget implements PreferredSizeWidget {
  WebAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      shadowColor: AppColors.orange,
      //backgroundColor: AppColors.primary,
      surfaceTintColor: AppColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
      title: Padding(
        padding: EdgeInsets.only(top: 10, left: 7, bottom: 10),
        child: Image.asset(
          'assets/images/Icon.png',
          height: 40,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 32),
          child: InkWell(
            onTap: () {
              AppRouter.goTOScreen(AccountPage.routeName);
            },
            child: Container(
              width: 42,
              height: 42,
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
      ],
      leadingWidth: 150,
      foregroundColor: AppColors.brown,
      // backgroundColor: Color(0xFFf4f3f8),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
