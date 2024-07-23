// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/Views/UserPaymentPage.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/core/utils/router/AppRouter.dart';
import 'package:grad_new_project/models/item_model.dart';
import 'package:grad_new_project/models/order_item_model.dart';
import 'package:grad_new_project/view_model/cart_cubit/cart_cubit.dart';
import 'package:grad_new_project/view_model/cart_cubit/cart_state.dart';
import 'package:grad_new_project/widgets/OrderDetailsCustomerInfoCard.dart';
import 'package:grad_new_project/widgets/OrderedItemDetails.dart';
import 'package:grad_new_project/widgets/OrderedItemDetailsCopy.dart';
import 'package:grad_new_project/widgets/OrderedItemQuantityIncDec.dart';
import 'package:grad_new_project/widgets/UserAppBar.dart';

class CartPage extends StatelessWidget {
  static const routeName = 'shopping-cart';
  bool isWeb;
  CartPage({
    Key? key,
    required this.isWeb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final CartCubit cartCubit = context.read<CartCubit>();

    return Scaffold(
      appBar: !isWeb
          ? UserAppBar(
              withLogo: false,
              generalSearch: true,
              title: "Shopping Cart",
            )
          : null,
      backgroundColor: AppColors.white,
      body: // this column must be the body if there is no items in the cart
          /*   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Center(
            child: Image.asset(
              "assets/images/Cart.jpg",
              height: size.height * 0.37,
            ),
          ),
          Container(
            width: size.width * 0.75,
            padding:
                EdgeInsets.only(left: isWeb ? 50 : 0, right: isWeb ? 50 : 0),
            child: Text(
              "Your Cart are Empty! Try to add some items to the Cart First.",
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

          Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              if (isWeb)
                Text(
                  'Shopping Cart',
                  style: GoogleFonts.anta(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 22)),
                ),
              SizedBox(
                height: size.height * 0.02,
              ),
              // updates
              SingleChildScrollView(
                child: BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return GridView.builder(
                        itemCount: cartCubit.orders['sub_orders'].length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 120,
                        ),
                        itemBuilder: (context, index) {
                          // use the OrderedItemDetails() instead of the OrderedItemDetailsCopy
                          // I used the Copy because I don't have the orderItem object

                          return OrderedItemDetailsCopy(
                            order: cartCubit.orders['sub_orders'][index]
                                ['items'][0],
                            quantityChild: OrderedItemQuantityIncDec(
                              order: cartCubit.orders['sub_orders'][index]
                                  ['items'][0],
                              index: index,
                            ),
                            withDeleteIcon: true,
                            index: index,
                          );
                        },
                      );
                    }),
              ),
              const SizedBox(
                height: 100,
              )
            ]),
          ),
          Positioned(
              bottom: 0,
              //top: size.height * 0.63,
              child: Container(
                padding: EdgeInsets.only(top: 10),
                width: size.width,
                height: 79,
                color: AppColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                          child: Text(
                            "Total",
                            style: GoogleFonts.philosopher(
                              textStyle: const TextStyle(
                                color: AppColors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: !isWeb ? size.width * 0.56 : size.width * 0.17,
                        ),
                        BlocConsumer<CartCubit, CartState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 5),
                                child: Text(
                                  "\$${cartCubit.totalPrice}",
                                  style: GoogleFonts.philosopher(
                                    textStyle: TextStyle(
                                      color: AppColors.brown,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                    Container(
                      width: !isWeb ? size.width * 0.9 : size.width * 0.25,
                      height: size.height * 0.047,
                      padding: EdgeInsets.only(left: 20),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ElevatedButton(
                            onPressed: () {
                              AppRouter.goTOScreen(UserPaymentPage.routeName);
                            },
                            child: Text(
                              "      Process to Checkout      ",
                              style: TextStyle(color: AppColors.white),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 2),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.primary),
                              overlayColor: MaterialStateProperty.all(
                                AppColors.primary,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: size.height,
          ),
        ],
      ),
    );
  }
}
