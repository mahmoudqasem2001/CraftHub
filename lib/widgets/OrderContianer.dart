import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/models/order_details_model.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../Views/ArtistOrdersPageDetails.dart';
import '../view_model/order_cubit/order_cubit.dart';
import '../view_model/order_cubit/order_state.dart';

class OrderContainer extends StatefulWidget {
  const OrderContainer({
    super.key,
  });

  @override
  State<OrderContainer> createState() => _OrderContainerState();
}

class _OrderContainerState extends State<OrderContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderListSuccess) {
            return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return OrderItem(
                  orderDetails: state.orders[index],
                  orderStatus: order.orderStatus,
                  orderDate: order.items.isEmpty
                      ? DateTime.now()
                      : order.items[0].createdAt,
                  orderNumber: order.id,
                  totalPrice: double.parse(order.totalPrice),
                );
              },
            );
          } else if (state is OrderFailure) {
            return Center(
                child: Text('Failed to load orders: ${state.message}'));
          } else {
            return Center(child: Text('No orders available.'));
          }
        },
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final OrderDetails orderDetails;
  final String orderStatus;
  final DateTime orderDate;
  final int orderNumber;
  final double totalPrice;

  const OrderItem({
    required this.orderDetails,
    required this.orderStatus,
    required this.orderDate,
    required this.orderNumber,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var containerWidth = size.width * 0.93;
    var containerHeight = size.height * 0.15;
    return Flexible(
      child: Container(
        width: containerWidth,
        height: containerHeight,
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.lightPurple),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.brown,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        orderStatus,
                        style: GoogleFonts.philosopher(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: 17)),
                      ),
                    ),
                    Text(
                      DateFormat('yyyyy-MM-dd hh:mm aaa').format(orderDate),
                      style: GoogleFonts.philosopher(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.brown,
                              fontSize: 18)),
                    )
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    pushWithNavBar(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArtistOrdersPageDetails(),
                            settings: RouteSettings(
                                name: "orderNumber", arguments: orderDetails)));
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                    color: AppColors.brown,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 2),
                  child: Icon(
                    Icons.discount_outlined,
                    color: AppColors.brown,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "Order",
                        style: GoogleFonts.philosopher(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(204, 75, 43, 32),
                                fontSize: 12)),
                      ),
                    ),
                    Text(
                      "#$orderNumber",
                      style: GoogleFonts.philosopher(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.brown,
                              fontSize: 17)),
                    )
                  ],
                ),
                Spacer(),
                // Padding(
                //   padding:
                //       EdgeInsets.only(left: 8, right: 2, top: 12, bottom: 2),
                //   child: Icon(
                //     Icons.attach_money_outlined,
                //     color: AppColors.brown,
                //     size: 24,
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "Total Price",
                        style: GoogleFonts.philosopher(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(204, 75, 43, 32),
                                fontSize: 12)),
                      ),
                    ),
                    Text(
                      "\$$totalPrice",
                      style: GoogleFonts.philosopher(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.brown,
                              fontSize: 17)),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
