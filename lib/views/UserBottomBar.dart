import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_new_project/Views/UserAccountPage.dart';
import 'package:grad_new_project/view_model/home_cubit/home_cubit.dart';
import 'package:grad_new_project/view_model/item_cubit/item_cubit.dart';
import 'package:grad_new_project/views/HomePage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../core/utils/router/AppColors.dart';
import 'FavoritesPage.dart';
//import 'HomePage.dart';

class UserBottomNavbar extends StatefulWidget {
  static String routeName = 'user-bottom-bar';
  const UserBottomNavbar({super.key});

  @override
  State<UserBottomNavbar> createState() => _UserBottomNavbarState();
}

class _UserBottomNavbarState extends State<UserBottomNavbar> {
  late PersistentTabController _controller;
  String searchValue = '';

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    //sendDummyData();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          inactiveIcon: const Icon(Icons.home_outlined),
          icon: const Icon(Icons.home_filled),
          title: "Home",
          activeColorPrimary: AppColors.lightPurple2,
          inactiveColorPrimary: AppColors.grey,
          activeColorSecondary: AppColors.primary,
          inactiveColorSecondary: AppColors.primary),
      PersistentBottomNavBarItem(
          inactiveIcon: const Icon(Icons.favorite_border),
          icon: const Icon(Icons.favorite),
          title: "Favorites",
          activeColorPrimary: AppColors.lightPurple2,
          inactiveColorPrimary: AppColors.grey,
          activeColorSecondary: AppColors.primary,
          inactiveColorSecondary: AppColors.primary),
      PersistentBottomNavBarItem(
          inactiveIcon: const Icon(Icons.person_outline),
          icon: const Icon(Icons.person),
          title: "Account",
          activeColorPrimary: AppColors.lightPurple2,
          inactiveColorPrimary: AppColors.grey,
          activeColorSecondary: AppColors.primary,
          inactiveColorSecondary: AppColors.primary),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: [
          HomePage(),
          FavoritesPage(),
          const UserAccountPage(),
        ],
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
