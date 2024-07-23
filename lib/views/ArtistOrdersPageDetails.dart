// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/models/order_details_model.dart';
import 'package:grad_new_project/widgets/OrderDetailsCustomerInfoCard.dart';
import 'package:grad_new_project/widgets/OrderedItemDetails.dart';
import 'package:grad_new_project/widgets/artist_order_item_details.dart';

import '../view_model/order_cubit/order_cubit.dart';
import '../view_model/order_cubit/order_state.dart';

class ArtistOrdersPageDetails extends StatelessWidget {
  static const routeName = "artist-Order-details";

  const ArtistOrdersPageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderDetails orderDetails =
        ModalRoute.of(context)!.settings.arguments as OrderDetails;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.02,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderDetailsCustomerInfoCard(
                    orderDetails: orderDetails,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 21),
                    child: Text(
                      'Ordered Items:',
                      style: GoogleFonts.philosopher(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.brown,
                              fontSize: 17)),
                    ),
                  ),
                  if (orderDetails.items.isEmpty)
                    Container(
                      padding: const EdgeInsets.only(left: 21),
                      height: 200,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        'Item not found',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.philosopher(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  if (orderDetails.items.isNotEmpty)
                    ...orderDetails.items.map(
                      (item) {
                        return ArtistOrderItemDetails(
                          withDeleteIcon: false,
                          orderItem: item,
                          quantityChild: Padding(
                            padding: EdgeInsets.only(
                                left: size.width * .17, top: 35),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Quantity",
                                  style: GoogleFonts.philosopher(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(204, 75, 43, 32),
                                          fontSize: 12)),
                                ),
                                Text(
                                  item.itemQuantity.toString(),
                                  style: GoogleFonts.philosopher(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.orange,
                                          fontSize: 19)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          Container(
            height: size.height * .07,
            width: size.width,
            color: const Color.fromRGBO(241, 230, 255, 1),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.2, left: 8),
                  child: IconButton(
                    onPressed: () {
                      // Your button action here
                    },
                    icon: Icon(
                      Icons.departure_board_rounded,
                      color: AppColors.primary,
                      size: 28,
                    ),
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Total Price = ${orderDetails.totalPrice}\$',
                    style: GoogleFonts.sahitya(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 19)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * .16),
                  child: IconButton(
                    onPressed: () {
                      // Your button action here
                    },
                    icon: Icon(
                      Icons.maps_ugc,
                      color: AppColors.primary,
                      size: 28,
                    ),
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
