// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/Views/ArtistProfileFromUser.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/shared/constants.dart';

import '../core/utils/router/AppColors.dart';

// ignore: must_be_immutable
class ItemWidgetAtUserPage extends StatefulWidget {
  // final Item productItem;
  bool inArtistProfilePage;
  bool isFavorites = false;
  Map<String, dynamic> item;
  void Function()? fun;

  ItemWidgetAtUserPage({
    super.key,
    required this.inArtistProfilePage,
    required this.isFavorites,
    required this.item,
    this.fun,
  });

  @override
  State<ItemWidgetAtUserPage> createState() => _ItemAtUserPageWidgetState();
}

class _ItemAtUserPageWidgetState extends State<ItemWidgetAtUserPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*final bool? isFavorites =
    // = isFavorites ? !isFavorites: false;
    bool _isFavorites;
    if (isFavorites != null) {
      _isFavorites = isFavorites!;
    } else {
      _isFavorites = false;
    }*/

    return Container(
      margin: const EdgeInsets.only(left: 8, bottom: 15, right: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightPurple2),
        borderRadius: BorderRadius.circular(16.0),
        color: AppColors.lightPurple,
      ),
      height: size.height * 0.1,
      width: size.width * 0.07,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.15,
                width: size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: AppColors.lightPurple,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        widget.item['image'].toString().contains(Constants.host)
                            ? widget.item['image']
                            : '${Constants.host}${widget.item['image']}',
                    fit: BoxFit.fill,
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
              // const SizedBox(height: 4.0),
              Text(
                //  productItem.name,
                widget.item['name'],
                style: GoogleFonts.anta(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 12),
                ),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              widget.inArtistProfilePage
                  ? Container(
                      height: 1,
                    )
                  : InkWell(
                      // onTap: () {
                      //   // AppRouter.goTOScreen(
                      //   //   ArtistProfileFromUser.routeName,
                      //   //   {
                      //   //     'artistId': widget.item['profile']['id'],
                      //   //   },
                      //   // );
                      // },
                      child: Text(
                        //Project Name (from the Artist)
                        "By ${widget.item['profile']['artist']}",
                        style: GoogleFonts.anta(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                              fontSize: 10),
                        ),
                      ),
                    ),

              Text(
                '${widget.item['price']}\$',
                style: GoogleFonts.anta(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                      fontSize: 12),
                ),
              ),
            ],
          ),
          widget.inArtistProfilePage
              ? Container(
                  height: 1,
                )
              : Positioned(
                  top: 0,
                  right: 5,
                  child: IconButton(
                    icon: Icon(
                      widget.isFavorites
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      color: AppColors.red,
                      size: 20,
                    ),
                    onPressed: () {
                      // setState(() {
                      //   widget.isFavorites = !widget.isFavorites;
                      // });
                      if (widget.fun != null) {
                        widget.fun!();
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
