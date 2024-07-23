import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/AddArtistItemPage.dart';
import 'package:grad_new_project/Views/ArtistOrdersPage.dart';
import 'package:grad_new_project/Views/ArtistProfilePage.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/widgets/WebAppBar.dart';

class WebArtistDrawar extends StatefulWidget {
  static const routeName = " web-artist-bar";
  const WebArtistDrawar({super.key});

  @override
  State<WebArtistDrawar> createState() => _WebArtistDrawarState();
}

class _WebArtistDrawarState extends State<WebArtistDrawar> {
  int _currentIndex = 1;
  var textStyle = GoogleFonts.philosopher(
      textStyle: TextStyle(
          fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 17));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WebAppBar(),
      body: Row(
        children: [
          SideMenu(
            builder: (data) => SideMenuData(
              header: Padding(
                padding: const EdgeInsets.only(top: 26.0, bottom: 22),
                child: Text(
                  //textAlign: TextAlign.center,
                  // 'Step into the spotlight\n talented artist!',
                  "Artist",
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
                        /*homeIsSelected = !homeIsSelected;
                        if (homeIsSelected == true) {
                          addIsSelected = false;
                          orderIsSelected = false;
                        }*/
                      });
                    },
                    titleStyle: textStyle,
                    selectedTitleStyle: textStyle,
                    title: 'Profile Page',
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
                    title: 'Add New Item',
                    icon: const Icon(
                      Icons.add_circle_outline_sharp,
                      color: AppColors.primary,
                    ),
                    selectedIcon: Icon(
                      Icons.add_circle_rounded,
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
                    title: 'Orders',
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColors.primary,
                    ),
                    selectedIcon: Icon(
                      Icons.shopping_bag,
                      color: AppColors.primary,
                    )),
              ],
              footer: const Text('Footer'),
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
        return const ArtistProfilePage();
      case 2:
        return const AddArtistItemPage();
      case 3:
        return const ArtistOrdersPage();
      default:
        return Center(
          child: Text('Invalid variable value'),
        );
    }
  }
}
