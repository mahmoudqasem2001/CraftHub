// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/ArtistOrdersPage.dart';
import 'package:grad_new_project/Views/CartPage.dart';
import 'package:grad_new_project/Views/product_details_view.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/view_model/home_cubit/home_cubit.dart';
import 'package:grad_new_project/widgets/DropDownList.dart';
import 'package:grad_new_project/widgets/ItemWidgetAtUserPage.dart';
import 'package:grad_new_project/widgets/UserAppBar.dart';

import '../models/category_model.dart';

class CategoryItemsPage extends StatelessWidget {
  static const String routeName = "category-items";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CategoryItemsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int categoryId = int.parse(args['categoryId']!);
    final HomeCubit homeCubit = context.read<HomeCubit>();
    // that only Items the user can reach is displayed

    List<Map<String, dynamic>> itemsList = args['items']!;

    var size = MediaQuery.of(context).size;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Scaffold(
        endDrawer: Drawer(
          width: 400,
          child: CartPage(
            isWeb: true,
          ),
        ),
        key: _scaffoldKey,
        floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: AppColors.primary,
            // focusColor: AppColors.primary,
            foregroundColor: AppColors.lightPurple,
            onPressed: () {
              if (isDesktop) {
                _scaffoldKey.currentState!.openEndDrawer();
              } else {
                AppRouter.goTOScreen(CartPage.routeName);
              }
            },
            child: const Icon(Icons.shopping_bag_rounded),
          ),
        ),
        appBar: UserAppBar(
          generalSearch: false,
          withLogo: false,
          title: categories[categoryId - 1].name,
          searchData: {'category_id': categoryId},
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* SizedBox(
                height: 15,
              ),*/
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 55),
                  child: DropDownList(
                    dropdownItems: filters,
                    width: size.width * .39,
                    hintText: "Filters",
                  ),
                ),
                DropDownList(
                  dropdownItems: sortByItems,
                  width: size.width * .39,
                  hintText: "Sort By",
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.7,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: size.height * 0.7,
                  child: Column(
                    children: [
                      BlocConsumer<HomeCubit, HomeState>(
                          bloc: homeCubit,
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is! HomeLoaded) {
                              return const SizedBox();
                            } else {
                              return SizedBox(
                                height: size.height * 0.7,
                                child: GridView.builder(
                                  itemCount: itemsList.length,
                                  // shrinkWrap:
                                  //   true, // Keep this as true to allow the GridView to shrink wrap its content
                                  //  physics:
                                  //     const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: !isDesktop ? 2 : 6,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0,
                                  ),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        itemsList[index]['is_favorite'] =
                                            state.favorites
                                                .firstWhere(
                                                  (element) =>
                                                      element['item']['id'] ==
                                                      itemsList[index]['id'],
                                                  orElse: () => {},
                                                )
                                                .isNotEmpty;

                                        itemsList[index]['fun'] =
                                            homeCubit.addItemFavorite;
                                        itemsList[index]['bloc_state'] = state;

                                        AppRouter.goTOScreen(
                                          ProductDetailsScreen.routeName,
                                          [
                                            itemsList[index],
                                            categories[categoryId - 1].name
                                          ],
                                        );
                                        // AppRouter.goTOScreen(
                                        //     UserItemDetailsPage.routeName,
                                        //     {"itemId": 1});
                                      },
                                      child: ItemWidgetAtUserPage(
                                        inArtistProfilePage: false,
                                        isFavorites: itemsList[index]
                                            ['is_favorite'],
                                        item: itemsList[index],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

List<DropdownMenuItem<String>> get filters {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        child: Text(
          "Filters",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(169, 75, 43, 32),
                  fontSize: 14)),
        ),
        value: "All"),
    DropdownMenuItem(
        child: Text(
          "Artists You follow",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 14)),
        ),
        value: "following"),
    DropdownMenuItem(
        child: Text(
          "Same Country",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 14)),
        ),
        value: "Country"),
    DropdownMenuItem(
        child: Text(
          "Same State",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 14)),
        ),
        value: "Same Country"),
  ];
  return menuItems;
}
