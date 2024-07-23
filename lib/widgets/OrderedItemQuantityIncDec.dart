// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/view_model/cart_cubit/cart_cubit.dart';

class OrderedItemQuantityIncDec extends StatefulWidget {
  final Map<String, dynamic> order;
  final int index;

  const OrderedItemQuantityIncDec({
    Key? key,
    required this.order,
    required this.index,
  }) : super(key: key);

  @override
  State<OrderedItemQuantityIncDec> createState() =>
      _OrderedItemQuantityIncDecState();
}

class _OrderedItemQuantityIncDecState extends State<OrderedItemQuantityIncDec> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.order['item_quantity'];
  }

  void changeQuantity(int value) {
    if (quantity + value > 0) {
      setState(() {
        quantity += value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final CartCubit cartCubit = context.read<CartCubit>();

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isDesktop = constraints.maxWidth > 900;

      return Padding(
          padding: EdgeInsets.only(
              left: !isDesktop ? size.width * .22 : size.width * .03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  changeQuantity(1);
                  cartCubit.updateQuantity(widget.index, quantity);
                },
                child: const Icon(
                  Icons.add_circle,
                  color: AppColors.lightPurple2,
                  size: 21,
                ),
                //hoverColor: AppColors.primary,
                // focusColor: AppColors.primary,
              ),
              Text(
                '$quantity',
                style: GoogleFonts.philosopher(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontSize: 19)),
              ),
              InkWell(
                onTap: () {
                  changeQuantity(-1);
                  cartCubit.updateQuantity(widget.index, quantity);
                },
                hoverColor: AppColors.primary,
                focusColor: AppColors.primary,
                child: const Icon(
                  Icons.remove_circle_rounded,
                  color: AppColors.lightPurple2,
                  size: 21,
                ),
              ),
            ],
          ));
    });
  }
}
