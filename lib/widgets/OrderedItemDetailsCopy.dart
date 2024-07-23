// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/Views/UserItemDetailsPage.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/models/order_item_model.dart';
import 'package:grad_new_project/shared/constants.dart';
import 'package:grad_new_project/view_model/cart_cubit/cart_cubit.dart';

import '../view_model/order_cubit/order_cubit.dart';
import '../view_model/order_cubit/order_state.dart';

class OrderedItemDetailsCopy extends StatelessWidget {
  final Map<String, dynamic> order;
  Widget quantityChild;
  bool withDeleteIcon;
  int index;
  OrderedItemDetailsCopy({
    Key? key,
    required this.order,
    required this.quantityChild,
    required this.withDeleteIcon,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final CartCubit cartCubit = context.read<CartCubit>();

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;

      return Container(
        width: !isDesktop ? size.width * 0.93 : size.width * 0.002,
        height: !isDesktop ? size.height * 0.148 : size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(241, 230, 255, 1),
        ),
        child: InkWell(
          onTap: () {
            AppRouter.goTOScreen(UserItemDetailsPage.routeName, {"itemId": 1});
          },
          child: Stack(
            children: [
              Container(
                width: !isDesktop ? size.width * 0.93 : size.width * 0.002,
                height: !isDesktop ? size.height * 0.148 : size.height * 0.2,
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.only(left: 20, right: 40, top: 5),
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
                              image: NetworkImage(
                                order['item_details']['image']
                                        .toString()
                                        .contains(Constants.host)
                                    ? order['item_details']['image']
                                    : '${Constants.host}${order['item_details']['image']}',
                              ), // Placeholder image URL
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 14, bottom: 8, left: 5, right: 8),
                          child: Text(
                            order['item_details']['name'].toString(),
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
                          padding: EdgeInsets.only(
                              top: 0, bottom: 8, left: 5, right: 8),
                          child: Text(
                            '\$${order['item_details']['price']}',
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
                    SizedBox(
                      width: !isDesktop ? 50 : 0,
                    ),
                    quantityChild,
                  ],
                ),
              ),
              withDeleteIcon
                  ? Positioned(
                      bottom: 23,
                      right: 20,
                      child: InkWell(
                        onTap: () => cartCubit.removeOrder(index),
                        child: const Icon(
                          Icons.delete_rounded,
                          color: AppColors.lightPurple2,
                          size: 20,
                        ),
                      ),
                    )
                  : const Spacer()
            ],
          ),
        ),
      );
    });
  }
}
