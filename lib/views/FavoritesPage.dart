import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/CartPage.dart';
import 'package:grad_new_project/Views/UserItemDetailsPage.dart';
import 'package:grad_new_project/Views/product_details_view.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/view_model/home_cubit/home_cubit.dart';
import 'package:grad_new_project/widgets/ItemWidgetAtUserPage.dart';
import 'package:grad_new_project/widgets/UserAppBar.dart';

class FavoritesPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = context.read<HomeCubit>();

    //int categoryId = int.parse(args['categoryId']!);
    //String userCountry = args['userCountry']!; // this important to make sure
    // that only Items the user can reach is displayed
    final Map<String, dynamic> dummyItem = {
      "id": 3,
      "created_at": "2024-06-20T09:53:12.181640Z",
      "updated_at": "2024-06-20T09:53:12.181671Z",
      "status": false,
      "name": "dd item 1",
      "price": "10.00",
      "description": "dd item 1",
      "per_item": 1,
      "count_likes": 0,
      "count_comments": 0,
      "count_orders": 0,
      "image": "https://tinypng.com/static/images/boat.png",
      "profile": {
        "artist_id": 4,
        "artist": "dd dd",
        "project_name": "dd project"
      },
      "category": 1
    };

    var size = MediaQuery.of(context).size;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;
      return Scaffold(
        key: _scaffoldKey, // Assign the key to Scaffold
        endDrawer: Drawer(
          width: 400,
          child: CartPage(
            isWeb: true,
          ),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: 'cart-button-form-fav',
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
        appBar: !isDesktop
            ? UserAppBar(
                generalSearch: true,
                withLogo: true,
              )
            : null,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8),
              child: Text(
                'My Favorites:',
                style: GoogleFonts.anta(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontSize: 17)),
              ),
            ),
            // to display the Items
            SizedBox(
              height: size.height * 0.75,
              child: SingleChildScrollView(
                child: /* Column(
                    children: [ItemAtUserPageWidget(), ItemAtUserPageWidget()],
                  ),*/
                    SizedBox(
                  height: size.height * 0.75,
                  child: BlocConsumer<HomeCubit, HomeState>(
                    bloc: homeCubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is! HomeLoaded) {
                        return const SizedBox();
                      } else {
                        return GridView.builder(
                          itemCount: state.favorites.length,
                          // shrinkWrap: true,
                          //  physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: !isDesktop ? 2 : 6,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            mainAxisExtent: 200,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                state.favorites[index]['item']['is_favorite'] =
                                    true;

                                state.favorites[index]['item']['fun'] =
                                    homeCubit.addItemFavorite;
                                state.favorites[index]['item']['bloc_state'] =
                                    state;

                                AppRouter.goTOScreen(
                                  ProductDetailsScreen.routeName,
                                  state.favorites[index]['item'],
                                );
                                // AppRouter.goTOScreen(
                                //     UserItemDetailsPage.routeName, {"itemId": 1});
                              },
                              child: ItemWidgetAtUserPage(
                                inArtistProfilePage: false,
                                isFavorites: true,
                                item: state.favorites[index]['item'],
                                fun: () => homeCubit.removeItemFavorite(
                                    index,
                                    state.favorites[index]['item']['id'],
                                    state),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ),

            //this column must displays only if there is no Items in the Favorites list for the user
            /*
              
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/Favorites.jpg",
                      height: size.height * 0.37,
                    ),
                  ),
                  Container(
                    width: size.width * 0.75,
                    child: Text(
                      "You have no Favorites to display here! Try to add some items to your Favorites First.",
                      style: GoogleFonts.anta(
                        textStyle: TextStyle(
                            color: Color.fromARGB(201, 111, 53, 165),
                            fontWeight: FontWeight.bold),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),*/
          ],
        ),
      );
    });
  }
}
