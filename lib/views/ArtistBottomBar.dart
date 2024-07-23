import 'package:flutter/material.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/views/AccountPage.dart';
import 'package:grad_new_project/views/ArtistProfilePage.dart';
import 'package:grad_new_project/widgets/ArtistCurvedBottomBar.dart';
import 'package:grad_new_project/widgets/MyAppBar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../core/utils/router/AppColors.dart';
import 'AddArtistItemPage.dart';
import 'ArtistOrdersPage.dart';

class ArtistBottomBar extends StatefulWidget {
  static String routeName = '/artist-bottom-bar';
  const ArtistBottomBar({super.key});

  @override
  State<ArtistBottomBar> createState() => _ArtistBottomBarState();
}

class _ArtistBottomBarState extends State<ArtistBottomBar> {
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens() {
    return [
      const ArtistProfilePage(),
      const AddArtistItemPage(),
      const ArtistOrdersPage(),
    ];
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
          inactiveIcon: const Icon(Icons.add_circle_outline),
          icon: const Icon(Icons.add_circle),
          title: "Add Item",
          activeColorPrimary: AppColors.lightPurple2,
          inactiveColorPrimary: AppColors.grey,
          activeColorSecondary: AppColors.primary,
          inactiveColorSecondary: AppColors.primary),
      PersistentBottomNavBarItem(
          inactiveIcon: const Icon(Icons.shopping_bag_outlined),
          icon: const Icon(Icons.shopping_bag),
          title: "Orders",
          activeColorPrimary: AppColors.lightPurple2,
          inactiveColorPrimary: AppColors.grey,
          activeColorSecondary: AppColors.primary,
          inactiveColorSecondary: AppColors.primary),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
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
