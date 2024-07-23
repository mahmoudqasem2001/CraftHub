// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/models/order_item_model.dart';
import 'package:grad_new_project/shared/constants.dart';

class ArtistOrderItemDetails extends StatelessWidget {
  final OrderItem orderItem;
  final Widget quantityChild;
  final bool withDeleteIcon;

  const ArtistOrderItemDetails({
    Key? key,
    required this.orderItem,
    required this.quantityChild,
    required this.withDeleteIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.93,
          height: MediaQuery.of(context).size.height * 0.148,
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.only(left: 20, right: 20, top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(241, 230, 255, 1),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(6),
                child: AspectRatio(
                  aspectRatio: .85,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                        image: NetworkImage(orderItem.item.image
                                .contains(Constants.host)
                            ? orderItem.item.image
                            : '${Constants.host}${orderItem.item.image}'), // Placeholder image URL
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 14, bottom: 8, left: 5, right: 8),
                    child: Text(
                      orderItem.item.name,
                      style: GoogleFonts.anton(
                        textStyle: TextStyle(
                          color: AppColors.brown,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 8),
                    child: Text(
                      "Price per Piece",
                      style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(204, 75, 43, 32),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 0, bottom: 8, left: 5, right: 8),
                    child: Text(
                      '\$${orderItem.item.perItem}',
                      style: GoogleFonts.philosopher(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.brown,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              quantityChild,
            ],
          ),
        ),
        withDeleteIcon
            ? Positioned(
                bottom: 13,
                right: 30,
                child: InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.delete_rounded,
                    color: AppColors.lightPurple2,
                    size: 20,
                  ),
                ),
              )
            : const Spacer()
      ],
    );
  }
}
