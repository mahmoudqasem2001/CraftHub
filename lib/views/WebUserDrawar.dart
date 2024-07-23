import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/AddArtistItemPage.dart';
import 'package:grad_new_project/Views/ArtistOrdersPage.dart';
import 'package:grad_new_project/Views/ArtistProfilePage.dart';
import 'package:grad_new_project/Views/FavoritesPage.dart';
import 'package:grad_new_project/Views/UserAccountPage.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/view_model/item_cubit/item_cubit.dart';
import 'package:grad_new_project/views/HomePage.dart';
import 'package:grad_new_project/widgets/WebAppBar.dart';
import 'package:grad_new_project/widgets/WebAppBarUser.dart';

class WebUserDrawar extends StatefulWidget {
  static const routeName = " web-user-bar";
  const WebUserDrawar({super.key});

  @override
  State<WebUserDrawar> createState() => _WebUserDrawarState();
}

class _WebUserDrawarState extends State<WebUserDrawar> {
  int _currentIndex = 1;
  var textStyle = GoogleFonts.philosopher(
      textStyle: TextStyle(
          fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 17));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WebAppBarUser(
        withLogo: true,
        generalSearch: true,
      ),
      body: Row(
        children: [
          SideMenu(
            builder: (data) => SideMenuData(
              header: Padding(
                padding: const EdgeInsets.only(top: 26.0, bottom: 22),
                child: Text(
                  //textAlign: TextAlign.center,
                  // 'Step into the spotlight\n talented artist!',
                  "User",
                  style: GoogleFonts.anta(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                          fontSize: 16)),
                ),
              ),
              items: [
                SideMenuItemDataTile(
                    highlightSelectedColor: AppColors.lightPurple2,
                    hoverColor: AppColors.lightPurple2,
                    isSelected: _currentIndex == 1,
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    titleStyle: textStyle,
                    selectedTitleStyle: textStyle,
                    title: 'Home Page',
                    icon: const Icon(
                      Icons.home_outlined,
                      color: AppColors.primary,
                    ),
                    selectedIcon: Icon(
                      Icons.home,
                      color: AppColors.primary,
                    )),
                SideMenuItemDataTile(
                    highlightSelectedColor: AppColors.lightPurple2,
                    hoverColor: AppColors.lightPurple2,
                    isSelected: _currentIndex == 2,
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                        /*addIsSelected = !addIsSelected;
                        if (addIsSelected == true) {
                          homeIsSelected = false;
                          orderIsSelected = false;
                        }*/
                      });
                    },
                    selectedTitleStyle: textStyle,
                    titleStyle: textStyle,
                    title: 'Favorites',
                    icon: const Icon(
                      Icons.favorite_border,
                      color: AppColors.primary,
                    ),
                    selectedIcon: Icon(
                      Icons.favorite,
                      color: AppColors.primary,
                    )),
                SideMenuItemDataTile(
                    highlightSelectedColor: AppColors.lightPurple2,
                    hoverColor: AppColors.lightPurple2,
                    isSelected: _currentIndex == 3,
                    onTap: () {
                      setState(() {
                        _currentIndex = 3;
                        /* orderIsSelected = !orderIsSelected;
                        if (orderIsSelected == true) {
                          addIsSelected = false;
                          homeIsSelected = false;
                        }*/
                      });
                    },
                    selectedTitleStyle: textStyle,
                    titleStyle: textStyle,
                    title: 'Account',
                    icon: const Icon(
                      Icons.person_outline,
                      color: AppColors.primary,
                    ),
                    selectedIcon: Icon(
                      Icons.person,
                      color: AppColors.primary,
                    )),
              ],
              // footer: const Text('Footer'),
            ),
          ),
          Expanded(
            child: Container(
                color: Colors.white,
                child: getChildWidget(
                    _currentIndex) /*const Center(
                child: Text(
                  'body',
                ),
              ),*/

                ),
          ),
          /* SideMenu(
            position: SideMenuPosition.right,
            builder: (data) => const SideMenuData(
              customChild: Text('Custom view'),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget getChildWidget(int index) {
    switch (index) {
      case 1:
        return BlocProvider(
          create: (context) => ItemCubit(),
          child: HomePage(),
        );
      case 2:
        return FavoritesPage();
      case 3:
        return const UserAccountPage();
      default:
        return Center(
          child: Text('Invalid variable value'),
        );
    }
  }
}
