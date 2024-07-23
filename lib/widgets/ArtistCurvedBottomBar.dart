// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:grad_new_project/Views/ArtistOrdersPageDetails.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/views/AccountPage.dart';
import 'package:grad_new_project/views/AddArtistItemPage.dart';
import 'package:grad_new_project/views/ArtistOrdersPage.dart';
import 'package:grad_new_project/views/ArtistProfilePage.dart';
import 'package:grad_new_project/widgets/MyAppBar.dart';

class ArtistCurvedBottomBar extends StatefulWidget {
  static String routeName = '/CurvedNavigationbar';
  ArtistCurvedBottomBar({
    super.key,
  });

  @override
  State<ArtistCurvedBottomBar> createState() => _MyCurvedNavigationbarState();
}

class _MyCurvedNavigationbarState extends State<ArtistCurvedBottomBar> {
  static int _page = 2;

  List<Widget> items = [
    Icon(
      Icons.home,
      size: 25,
      color: AppColors.white,
    ),
    Icon(
      Icons.add_circle,
      size: 25,
      color: AppColors.white,
    ),
    Icon(
      Icons.shopping_bag_rounded,
      size: 25,
      color: AppColors.white,
    )
  ];
  List<Widget> screens = [
    ArtistProfilePage(),
    AddArtistItemPage(),
    ArtistOrdersPage(),
    ArtistOrdersPageDetails()
  ];
  _MyCurvedNavigationbarState();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(),
      //body: screens[],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.white,
        color: AppColors.primary,
        animationDuration: Duration(milliseconds: 150),
        height: size.height * 0.068,
        index: _page,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        items: items,
      ),
      body: screens[_page],
    );
  }
}
