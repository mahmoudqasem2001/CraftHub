import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/CartPage.dart';
import 'package:grad_new_project/Views/CategoryItemsPage.dart';
import 'package:grad_new_project/Views/product_details_view.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/shared/constants.dart';
import 'package:grad_new_project/view_model/home_cubit/home_cubit.dart';
import 'package:grad_new_project/widgets/UserAppBar.dart';
import '../models/announcement_model.dart';
import '../widgets/CustomCarouselIndicatior.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home';
  HomePage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final HomeCubit cubit = BlocProvider.of<HomeCubit>(context);
    /* final itemCubit = BlocProvider.of<ItemCubit>(context);
    return BlocBuilder<ItemCubit, ItemState>(
      bloc: itemCubit,
      buildWhen: (previous, current) =>
          current is ItemLoading ||
          current is ItemListSuccess ||
          current is ItemFailure,
      builder: (context, state) {
        if (state is ItemLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is ItemFailure) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is ItemListSuccess) {
          final products = state.items;*/
    final List<AnnouncementModel> announcements =
        dummyAnnouncements; // Placeholder for announcements
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
            heroTag: 'cart-button-form-home',
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
        appBar: isDesktop
            ? null
            : UserAppBar(
                withLogo: true,
                generalSearch: true,
              ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24.0),
                CustomCarouselIndicator(announcements: announcements),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Text(
                      'Categories',
                      style: GoogleFonts.anta(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontSize: 20)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocConsumer<HomeCubit, HomeState>(
                    bloc: cubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is! HomeLoaded) {
                        return const SizedBox(
                          height: 100,
                        );
                      } else {
                        return SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // print(state.categories[index].items);
                                  AppRouter.goTOScreen(
                                    CategoryItemsPage.routeName,
                                    {
                                      'categoryId': state.categories[index].id,
                                      'userCountry': 'country',
                                      'items': state.categories[index].items,
                                    },
                                  );
                                  //print(categories[index].name);
                                },
                                focusColor: AppColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        state.categories[index].imgUrl,
                                        width: 60,
                                        height: 60,
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                          state.categories[index].name,
                                          style: const TextStyle(
                                            color: AppColors.grey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 9,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Artists',
                      style: GoogleFonts.anta(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
                BlocConsumer<HomeCubit, HomeState>(
                  bloc: cubit,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is! HomeLoaded) {
                      return const SizedBox(height: 100);
                    } else {
                      print(state.artists);
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.artists.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      state.artists[index]['name'] ?? " ",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' (${state.artists[index]['project_name'] ?? " "})',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                if (state.artists[index]['items'].isEmpty)
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      'Not have any items yet',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.anta(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (state.artists[index]['items'].isNotEmpty)
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        state.artists[index]['items'].length,
                                    itemBuilder: (context, itemIndex) {
                                      return InkWell(
                                        onTap: () {
                                          state.artists[index]['items']
                                                  [itemIndex]['is_favorite'] =
                                              state.favorites
                                                  .firstWhere(
                                                    (element) =>
                                                        element['item']['id'] ==
                                                        state.artists[index]
                                                                ['items']
                                                            [itemIndex]['id'],
                                                    orElse: () => {},
                                                  )
                                                  .isNotEmpty;

                                          state.artists[index]['items']
                                                  [itemIndex]['fun'] =
                                              cubit.addItemFavorite;
                                          state.artists[index]['items']
                                              [itemIndex]['bloc_state'] = state;

                                          AppRouter.goTOScreen(
                                            ProductDetailsScreen.routeName,
                                            state.artists[index]['items']
                                                [itemIndex],
                                          );
                                        },
                                        child: Card(
                                          child: ListTile(
                                            leading: Image.network(
                                              '${Constants.host}${state.artists[index]['items'][itemIndex]['image']}',
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                            title: Text(state.artists[index]
                                                ['items'][itemIndex]['name']),
                                            subtitle: Text(
                                              '\$${state.artists[index]['items'][itemIndex]['price']}',
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  '${state.artists[index]['items'][itemIndex]['count_likes']} likes',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                Text(
                                                  '${state.artists[index]['items'][itemIndex]['count_comments']} comments',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          );
                        },
                      );

                      // return GridView.builder(
                      //   itemCount: state.products.length,
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   gridDelegate:
                      //       const SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 2,
                      //     mainAxisSpacing: 20,
                      //     crossAxisSpacing: 10,
                      //   ),
                      //   itemBuilder: (context, index) {
                      //     return InkWell(
                      //       onTap: () {},
                      //       child: Container(
                      //         color: Colors.red,
                      //       ),
                      //     );
                      //   },
                      // );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  } /*else {
          return const SizedBox(
            child: Text('data'),
          );
        }*/
}
    //);
  //}
//}

