import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/ArtistProfileFromUser.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/view_model/item_cubit/item_cubit.dart';
import 'package:grad_new_project/view_model/item_cubit/item_state.dart';
import 'package:grad_new_project/widgets/CommentWidget.dart';
import 'package:grad_new_project/widgets/LikeAndCommentWidget.dart';

import '../models/item_model.dart';

class UserItemDetailsPage extends StatefulWidget {
  static const String routeName = "user-item-details";
  const UserItemDetailsPage({super.key});

  @override
  State<UserItemDetailsPage> createState() => _UserItemDetailsPageState();
}

class _UserItemDetailsPageState extends State<UserItemDetailsPage> {
  bool _addedToChart = false;
  bool _addedToFavorite = false; // we must get this from database
  int quantity = 0;
  TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Map<String, int?> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, int?>;
    int itemId =
        args['itemId']!; // use this for getting the item from the Items table
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: size.width * .16, bottom: 50),
        child: Tooltip(
          message: 'Message the Artist',
          child: IconButton(
            onPressed: () {
              // Your button action here
            },
            icon: Icon(
              Icons.chat_bubble_rounded,
              color: AppColors.lightPurple,
              size: 27,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.brown,
          ),
          onPressed: () {
            AppRouter.goBackTOScreen();
          },
        ),
        title: Text(
          "Item details",
          style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown,
                  fontSize: 19)),
        ),
      ),
      body: BlocProvider<ItemCubit>(
        create: (context) => ItemCubit()..fetchItemDetailsForCustomer(itemId),
        child: BlocBuilder<ItemCubit, ItemState>(
          builder: (context, state) {
            if (state is ItemLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ItemDetailsSuccess) {
              final item = state.item;
              return _buildItemDetails(context, size, item);
            } else if (state is ItemFailure) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('Unexpected state'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildItemDetails(BuildContext context, Size size, Item item) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.36,
                margin: EdgeInsets.only(left: 16, bottom: 5, right: 16),
                decoration: BoxDecoration(
                  color: AppColors.lightPurple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    width: size.width,
                    height: size.height * 0.35,
                    imageUrl:
                        'https://parspng.com/wp-content/uploads/2022/07/Tshirtpng.parspng.com_.png',
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  item.name,
                  style: GoogleFonts.philosopher(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBrown,
                          fontSize: 22)),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(right: 16.0, left: 16),
                  height: 50.0,
                  child: Column(children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          item.description,
                          style: GoogleFonts.philosopher(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkBrown,
                                  fontSize: 12)),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              InkWell(
                onTap: () {
                  AppRouter.goTOScreen(
                      ArtistProfileFromUser.routeName, {'artistId': 1});
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12),
                  child: Text(
                    "Artist Name ~ Project Name",
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.overlayColor,
                            fontSize: 15)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 6, right: 16),
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.lightPurple2, // Color of the border
                        width: 1.0, // Width of the border
                      ),
                    ),
                  ),
                  child: Text(
                    "\$${item.price}",
                    style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 18)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle,
                        color: AppColors.lightPurple2,
                        size: 21,
                      ),
                    ),
                    Text(
                      '$quantity',
                      style: GoogleFonts.philosopher(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontSize: 19)),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle,
                        color: AppColors.lightPurple2,
                        size: 21,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _addedToChart = !_addedToChart;
                            });
                          },
                          child: Container(
                            width: size.width * 0.3,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_bag_outlined,
                                    color: _addedToChart
                                        ? AppColors.white
                                        : AppColors.primary),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                      color: _addedToChart
                                          ? AppColors.white
                                          : AppColors.primary),
                                ),
                              ],
                            ),
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              _addedToChart
                                  ? AppColors.primary
                                  : AppColors.lightPurple,
                            ),
                            overlayColor: MaterialStateProperty.all(
                                AppColors.lightPurple2),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _addedToFavorite = !_addedToFavorite;
                            });
                          },
                          child: Container(
                            width: size.width * 0.24,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.favorite_outline_rounded,
                                    color: _addedToFavorite
                                        ? AppColors.white
                                        : AppColors.darkBrown),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Favorite",
                                  style: TextStyle(
                                      color: _addedToFavorite
                                          ? AppColors.white
                                          : AppColors.darkBrown),
                                ),
                              ],
                            ),
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              _addedToFavorite
                                  ? AppColors.primary
                                  : AppColors.white,
                            ),
                            overlayColor: MaterialStateProperty.all(
                                AppColors.lightPurple2),
                          ),
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ExpansionTile(
                    leading: Container(
                      padding: EdgeInsets.only(right: 16, left: 16),
                      width: size.width * .4,
                      child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: AppColors.primary,
                          ),
                          Text(
                            "${item.countLikes}K",
                            style: GoogleFonts.anta(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.overlayColor,
                                    fontSize: 12)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.comment,
                            color: AppColors.hintTextColor,
                          ),
                          Text(
                            "${item.countComments}K",
                            style: GoogleFonts.anta(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.overlayColor,
                                    fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    // trailing: Text("15"),
                    title: Container(),
                    children: [
                      SingleChildScrollView(
                        child: Column(
                            children: List<Widget>.generate(
                                15, (int index) => CommentWidget())),
                      )
                    ]),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            //top: size.height * 0.63,
            child: Container(
                padding: EdgeInsets.only(top: 10),
                width: size.width,
                height: 60,
                color: AppColors.white,
                child: LikeAndCommentWidget(
                  itemId: item.id,
                  userId: 1,

                  ///Issue: need to get the current user
                  commentController: _commentController,
                ))),
        SizedBox(
          height: size.height,
        ),
      ],
    );
  }
}
