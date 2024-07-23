// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/Views/ArtistProfileFromUser.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/shared/constants.dart';

import '../core/utils/router/AppColors.dart';

// ignore: must_be_immutable
class ArtistCardWidget extends StatefulWidget {
  // final Item productItem;
  Map<String, dynamic> artist;
  void Function()? fun;

  ArtistCardWidget({
    super.key,
    required this.artist,
    this.fun,
  });

  @override
  State<ArtistCardWidget> createState() => _ItemAtUserPageWidgetState();
}

class _ItemAtUserPageWidgetState extends State<ArtistCardWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(left: 8, bottom: 15, right: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightPurple2),
        borderRadius: BorderRadius.circular(16),
        color: AppColors.lightPurple,
      ),
      height: size.height * 0.1,
      width: size.width * 0.07,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
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
                    imageUrl: widget.artist['image']
                            .toString()
                            .contains(Constants.host)
                        ? widget.artist['image']
                        : '${Constants.host}${widget.artist['profile']['image']}',
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
                widget.artist['first_name'] + ' ' + widget.artist['last_name'],
                style: GoogleFonts.anta(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: 17,
                  ),
                ),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                //Project Name (from the Artist)
                "${widget.artist['profile']['project_name']}",
                style: GoogleFonts.anta(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
