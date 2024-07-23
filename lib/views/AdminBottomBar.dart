import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/AdminHomePage.dart';
import 'package:grad_new_project/Views/AdminReportsPage.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/views/AccountPage.dart';
import 'package:grad_new_project/views/ArtistProfilePage.dart';
import 'package:grad_new_project/widgets/ArtistCurvedBottomBar.dart';
import 'package:grad_new_project/widgets/MyAppBar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../core/utils/router/AppColors.dart';
import 'AddArtistItemPage.dart';
import 'ArtistOrdersPage.dart';

class AdminBottomBar extends StatefulWidget {
  static String routeName = '/admin-bottom-bar';
  const AdminBottomBar({super.key});

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens() {
    return [
      AdminHomePage(),
      const AdminReportsPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          inactiveIcon: const Icon(Icons.category_outlined),
          icon: const Icon(Icons.category),
          title: "Categories",
          activeColorPrimary: AppColors.lightPurple2,
          inactiveColorPrimary: AppColors.grey,
          activeColorSecondary: AppColors.primary,
          inactiveColorSecondary: AppColors.primary),
      PersistentBottomNavBarItem(
          inactiveIcon: const Icon(Icons.report_outlined),
          icon: const Icon(Icons.report),
          title: "Report",
          activeColorPrimary: AppColors.lightPurple2,
          inactiveColorPrimary: AppColors.grey,
          activeColorSecondary: AppColors.primary,
          inactiveColorSecondary: AppColors.primary),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.orange,
        surfaceTintColor: AppColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        leading: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Image.asset(
            'assets/images/Icon.png',
            height: 40,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Admin View',
            style: GoogleFonts.philosopher(
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brown)),
          ),
        ),
        leadingWidth: 160,
        foregroundColor: AppColors.brown,
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        stateManagement: false,
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style7, // Choose the nav bar style with this property.
      ),
    );
  }
}
